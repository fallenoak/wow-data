module WOW::Capture::Packets::SMSG
  class Emote < WOW::Capture::Packets::Base
    attr_reader :guid, :emote_id, :emote_type

    def parse!
      @guid = read_packed_guid128
      @emote_id = read_int32

      @emote_type = WOW::Capture::Packets::Entities::Emote::TYPES[@emote_id]

      update_wow_object
    end

    private def update_wow_object
      wow_object = parser.objects.find_or_create(@guid)
      wow_object.emote!(self)
    end
  end
end
