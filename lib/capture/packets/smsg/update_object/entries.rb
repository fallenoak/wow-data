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
        attr_reader :guid, :updated_values

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type = @guid.object_type
          @updated_values = read_values

          wow_object = @packet.storage.find(@guid)
          wow_object.update!(@updated_values)
        end
      end

      class CreateObjectEntry < Entries::Base
        attr_reader :guid, :object_type, :object_type_id, :movement, :values

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type_id = @packet.read_byte
          @object_type = WOW::Capture::OBJECT_TYPES[@object_type_id]
          @movement = read_movements
          @values = read_values

          wow_object = WOW::Capture::WOWObject.new(@guid, @object_type, @movement, @values)
          @packet.storage.save(wow_object)
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
