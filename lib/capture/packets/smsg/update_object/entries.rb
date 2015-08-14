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

        def inspect
          excluded_variables = [:@packet]
          all_variables = instance_variables
          variables = all_variables - excluded_variables

          prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

          parts = []

          variables.each do |var|
            parts << "#{var}=#{instance_variable_get(var).inspect}"
          end

          str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

          str
        end
      end

      class ValuesEntry < Entries::Base
        attr_reader :guid, :raw_updated_values

        private def parse!
          @guid = @packet.read_packed_guid128
          @object_type = @guid.object_type
          @raw_updated_values = read_values

          wow_object = @packet.parser.objects.find(@guid)
          wow_object.update_attributes!(@packet, @raw_updated_values)
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

          wow_object = @packet.parser.objects.find_or_create(@guid)
          wow_object.spawn!(@packet, @raw_movement_state, @raw_values_state)
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
