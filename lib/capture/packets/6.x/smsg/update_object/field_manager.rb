module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module FieldManager
      def self.field_at_index(update_fields, object_type, field_index)
        fields_table = table_for(update_fields, object_type)

        if fields_table.nil?
          field_entry, field_offset = [nil, nil]
        else
          field_entry, field_offset = find_field_entry(fields_table, field_index)
        end

        # Unknown field
        if field_entry.nil?
          field_name = "field_#{field_index}"
          field_type = :uint32
          field_size = 1
          block_offset = 0
        # Repeated single-block field
        elsif field_entry.blocks == 1 && field_offset > 0
          field_name = "#{field_entry.value}_#{field_offset + 1}"
          field_type = field_entry.type
          field_size = field_entry.blocks
          block_offset = 0
        # Multi-block field
        else
          field_name = field_entry.value
          field_type = field_entry.type
          field_size = field_entry.blocks
          block_offset = field_offset
        end

        [field_name, field_type, field_size, block_offset]
      end

      def self.table_for(update_fields, object_type)
        case object_type
        when :unit
          update_fields.unit_fields
        when :player
          update_fields.player_fields
        when :item
          update_fields.item_fields
        when :game_object
          update_fields.game_object_fields
        when :container
          update_fields.container_fields
        when :corpse
          update_fields.corpse_fields
        when :area_trigger
          update_fields.area_trigger_fields
        else
          nil
        end
      end

      def self.find_field_entry(table, field_index)
        if table.find(field_index)
          # Exact match.
          matched_entry = table.find(field_index)
          difference = 0
        else
          # Match on immediately previous entry to given index.
          matched_entry = table.prev(field_index)
          difference = field_index - matched_entry.index
        end

        [matched_entry, difference]
      end
    end
  end
end
