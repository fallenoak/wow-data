module WOW::Capture::Packets::SMSG
  class TextEmote < WOW::Capture::Packets::Base
    attr_reader :source_guid, :target_guid, :emote_id, :emote_type, :sound_index

    def parse!
      @source_guid = read_packed_guid128
      @wow_account_guid = read_packed_guid128
      @emote_id = read_int32
      @sound_index = read_int32
      @target_guid = read_packed_guid128

      @emote_type = parser.defs.text_emotes[@emote_id]
    end

    private def track_references!
      if @source_guid.creature?
        add_reference!('Sender', :sender, :creature, @source_guid.entry_id)
      end

      if @target_guid.creature?
        add_reference!('Target', :target, :creature, @target_guid.entry_id)
      end
    end

    private def update_state!
      target = parser.objects.find_or_create(@target_guid)

      source = parser.objects.find_or_create(@source_guid)
      source.text_emote!(self)
    end
  end
end
