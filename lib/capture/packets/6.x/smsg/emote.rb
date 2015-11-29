module WOW::Capture::Packets::SMSG
  class Emote < WOW::Capture::Packets::Base
    attr_reader :guid, :emote_id, :emote_type

    def parse!
      @guid = read_packed_guid128
      @emote_id = read_int32

      @emote_type = parser.defs.emotes[@emote_id]
    end

    private def track_references!
      if @guid.creature?
        add_reference!('Sender', :sender, :creature, @guid.entry_id)
      end
    end

    private def update_state!
      wow_object = parser.objects.find_or_create(@guid)
      wow_object.emote!(self)
    end
  end
end
