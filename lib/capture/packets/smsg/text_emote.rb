module WOW::Capture::Packets::SMSG
  class TextEmote < WOW::Capture::Packets::Base
    attr_reader :source_guid, :target_guid, :emote_id, :emote_type, :sound_index

    def parse!
      @source_guid = read_packed_guid128
      @wow_account_guid = read_packed_guid128
      @emote_id = read_int32
      @sound_index = read_int32
      @target_guid = read_packed_guid128

      @emote_type = WOW::Capture::Packets::Entities::Emote::TYPES[@emote_id]

      update_wow_object
    end

    private def update_wow_object
      source_wow_object = parser.objects.find(@source_guid)
      source_wow_object.emote_text!(self) if !source_wow_object.nil?

      target_wow_object = parser.objects.find(@target_guid)
      target_wow_object.emote_text!(self) if !target_wow_object.nil?
    end
  end
end
