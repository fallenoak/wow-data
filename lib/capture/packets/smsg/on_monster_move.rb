module WOW::Capture::Packets::SMSG
  class OnMonsterMove < WOW::Capture::Packets::Base
    attr_reader :guid, :position

    def parse!
      @guid = read_packed_guid128
      @position = WOW::Capture::Coordinate.new(read_vector(3))

      update_wow_object
    end

    private def update_wow_object
      wow_object = parser.objects.find(@guid)
      return if wow_object.nil?

      wow_object.move!(self)
    end
  end
end
