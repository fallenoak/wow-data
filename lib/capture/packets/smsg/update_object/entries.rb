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
        attr_reader :guid, :updates

        private def parse!
          @guid = @packet.read_packed_guid128
          @updates = read_values
        end
      end

      class CreateObjectEntry < Entries::Base
        attr_reader :guid, :object_type, :object_type_id, :movements, :object

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type_id = @packet.read_byte
          @object_type = WOW::Capture::OBJECT_TYPES[@object_type_id]
          @movements = read_movements
          @object = read_values
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
