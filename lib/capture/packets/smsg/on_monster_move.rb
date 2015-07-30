module WOW::Capture::Packets::SMSG
  class OnMonsterMove < WOW::Capture::Packets::Base
    attr_reader :guid, :position

    def parse!
      @guid = read_packed_guid128
      @position = WOW::Capture::Coordinate.new(read_vector(3))
    end

    private def update_wow_objects!
      wow_object = parser.objects.find_or_create(@guid)
      wow_object.move!(self)
    end
  end
end
