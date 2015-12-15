module WOW::Capture::Packets::SMSG
  class TextEmote < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :sender_guid,         packed: true
        guid128   :wow_account_guid,    packed: true

        int32     :emote_id
        int32     :sound_index

        guid128   :target_guid,         packed: true
      end
    end

    private def track_references!
      if record.sender_guid.creature?
        add_reference!('Sender', :sender, :creature, record.sender_guid.entry_id)
      end

      if record.target_guid.creature?
        add_reference!('Target', :target, :creature, record.target_guid.entry_id)
      end
    end

    private def update_state!
      target = parser.objects.find_or_create(record.target_guid)

      sender = parser.objects.find_or_create(record.sender_guid)
      sender.text_emote!(self)
    end
  end
end
