module WOW::Capture::Packets::SMSG
  class OnMonsterMove < WOW::Capture::Packets::Base
    attr_reader :guid, :position

    def parse!
      @guid = read_packed_guid64
      @position = WOW::Capture::Coordinate.new(read_vector(3))
    end

    private def track_references!
      if @guid.creature?
        add_reference!('Mover', :mover, :creature, @guid.entry_id)
      end
    end

    private def update_state!
      wow_object = parser.objects.find_or_create(@guid)
      wow_object.move!(self)
    end
  end
end
