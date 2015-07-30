module WOW::Capture::Packets::SMSG
  class TextEmote < WOW::Capture::Packets::Base
    attr_reader :source_guid, :target_guid, :emote_id, :emote_type, :sound_index

    def parse!
      @source_guid = read_packed_guid128
      @wow_account_guid = read_packed_guid128
      @emote_id = read_int32
      @sound_index = read_int32
      @target_guid = read_packed_guid128

      @emote_type = WOW::Capture::Packets::Entities::TextEmote::TYPES[@emote_id]
    end

    private def update_wow_objects!
      target = parser.objects.find_or_create(@target_guid)

      source = parser.objects.find_or_create(@source_guid)
      source.text_emote!(self)
    end
  end
end
