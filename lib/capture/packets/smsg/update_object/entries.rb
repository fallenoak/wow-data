module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module Entries
      class Base
        include Readers

        attr_reader :index

        def initialize(packet, index)
          @packet = packet
          @index = index
          parse!
        end

        def parse!
        end
      end

      class ValuesEntry < Entries::Base
        attr_reader :guid, :raw_updated_values

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type = @guid.object_type
          @raw_updated_values = read_values

          wow_object = @packet.parser.objects.find(@guid)
          wow_object.update_values!(@raw_updated_values)
        end
      end

      class CreateObjectEntry < Entries::Base
        attr_reader :guid, :object_type, :object_type_id, :raw_movement_state, :raw_values_state

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type_id = @packet.read_byte
          @object_type = WOW::Capture::OBJECT_TYPES[@object_type_id]
          @raw_movement_state = read_movements
          @raw_values_state = read_values

          wow_object = WOW::Capture::WOWObject::Manager.build_from_guid(@guid)
          wow_object.initialize_movement_state(@raw_movement_state)
          wow_object.initialize_values_state(@raw_values_state)
          @packet.parser.objects.create(wow_object, @packet)
        end
      end

      # Legacy?
      class DestroyObjectsEntry < Entries::Base
        attr_reader :objects_count, :object_guids

        private def parse!
          @object_guids = []
          @objects_count = @packet.read_int32

          @objects_count.times do
            @object_guids << @packet.read_packed_guid128
          end
        end
      end
    end
  end
end
