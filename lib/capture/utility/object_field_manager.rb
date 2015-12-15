module WOW::Capture::Utility
  module ObjectFieldManager
    @cache = {}

    def self.lookup_field(object_fields, object_type, field_index)
      cache_key = [object_fields.object_id, object_type.object_id, field_index].hash

      cache_result = @cache[cache_key]
      return cache_result if !cache_result.nil?

      fields_table = table_for(object_fields, object_type)

      if fields_table.nil?
        field_entry, field_offset = [nil, nil]
      else
        field_entry, field_offset = find_field_entry(fields_table, field_index)
      end

      # Unknown field
      if field_entry.nil?
        field_name = "field_#{field_index}".to_sym
        field_type = :uint32
        field_size = 1
        block_offset = 0
      # Repeated single-block field
      elsif field_entry.blocks == 1 && field_offset > 0
        field_name = "#{field_entry.value}_#{field_offset + 1}".to_sym
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

      lookup = [field_name, field_type, field_size, block_offset]

      @cache[cache_key] = lookup

      lookup
    end

    def self.table_for(object_fields, object_type)
      case object_type
      when :unit
        object_fields.unit_fields
      when :player
        object_fields.player_fields
      when :item
        object_fields.item_fields
      when :game_object
        object_fields.game_object_fields
      when :container
        object_fields.container_fields
      when :corpse
        object_fields.corpse_fields
      when :area_trigger
        object_fields.area_trigger_fields
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
