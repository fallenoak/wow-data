module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        uint32    :entries_length

        int16     :map_id

        reset_bit_reader

        bit       :has_destroyed_objects

        cond      if: proc { has_destroyed_objects } do
          uint16  :unknown_1

          uint32  :destroyed_objects_length

          array   :destroyed_objects, length: proc { destroyed_objects_length } do
                    guid128 packed: true
                  end
        end

        uint32    :payload_size

        array     :entries, length: proc { entries_length } do
                    struct source: :object_entry
                  end
      end
    end

    def update_state!
      if record.has_destroyed_objects
        record.destroyed_objects.each do |guid|
          object = parser.objects.find(guid)
          object.destroy_object!(self)
        end
      end

      record.entries.each do |entry|
        case entry.entry_type
        when :create1
          handle_object_create1_payload(entry.payload)
        when :create2
          handle_object_create2_payload(entry.payload)
        when :update
          handle_object_update_payload(entry.payload)
        when :destroy
          handle_object_destroy_payload(entry.payload)
        end
      end
    end

    private def handle_object_create1_payload(payload)
      parsed_values = {}

      payload.values.each_pair do |field_name, field_update|
        value = WOW::Capture::Types::ObjectValue.new(parser, field_update)
        parsed_values[field_name] = value
        field_update.value = value.value
      end

      wow_object = parser.objects.find_or_create(payload.guid)
      wow_object.create_object!(self, payload.movement_state, parsed_values)
    end

    private def handle_object_create2_payload(payload)
      parsed_values = {}

      payload.values.each_pair do |field_name, field_update|
        value = WOW::Capture::Types::ObjectValue.new(parser, field_update)
        parsed_values[field_name] = value
        field_update.value = value.value
      end

      wow_object = parser.objects.find_or_create(payload.guid)
      wow_object.create_object!(self, payload.movement_state, parsed_values)
    end

    private def handle_object_update_payload(payload)
      wow_object = parser.objects.find(payload.guid)

      updated_values = {}
      existing_values = wow_object.attributes.object_values

      payload.values.each_pair do |field_name, field_update|
        value = existing_values[field_name]

        if value.nil?
          value = WOW::Capture::Types::ObjectValue.new(parser, field_update)
        else
          value.update!(field_update)
        end

        updated_values[field_name] = value
        field_update.value = value.value
      end

      wow_object.update_attributes!(self, updated_values)
    end
  end
end
