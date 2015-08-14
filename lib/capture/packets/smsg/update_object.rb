module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    include WOW::Capture::Packets::Readers::PetBattle

    attr_reader :entries_count, :entries, :destroyed_objects

    def parse!
      @entries_count = read_uint32

      @map_id = read_uint16

      reset_bit_reader
      @has_destroyed_objects = false
      @destroyed_objects = []
      parse_destroyed_objects!

      @payload_size = read_uint32

      @entries = []
      parse_entries!
    end

    private def parse_entries!
      (0...@entries_count).each do |index|
        type = read_byte
        parse_entry!(type, index)
      end
    end

    private def parse_entry!(type, index)
      case type
      when EntryTypes::VALUES
        entry = Entries::ValuesEntry.new(self, index)
      when EntryTypes::CREATE_OBJECT_1, EntryTypes::CREATE_OBJECT_2
        entry = Entries::CreateObjectEntry.new(self, index)
      when EntryTypes::DESTROY_OBJECTS
        raise "Deprecated entry type: #{type} at index #{index}"
      else
        raise "Unexpected entry type: #{type} at index #{index}"
      end

      @entries << entry
    end

    private def parse_destroyed_objects!
      @destroyed_objects = []
      @has_destroyed_objects = read_bit

      if @has_destroyed_objects
        read_uint16

        destroy_objects_count = read_uint32

        destroy_objects_count.times do
          @destroyed_objects << read_packed_guid128
        end
      end

      @destroyed_objects.each do |guid|
        object = parser.objects.find(guid)
        object.despawn!(self)
      end
    end
  end
end
