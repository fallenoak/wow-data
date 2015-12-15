module WOW::Capture::Packets::SMSG
  class Emote < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :sender_guid,         packed: true
        int32     :emote_id
      end
    end

    private def track_references!
      if record.sender_guid.creature?
        add_reference!('Sender', :sender, :creature, record.sender_guid.entry_id)
      end
    end

    private def update_state!
      wow_object = parser.objects.find_or_create(record.sender_guid)
      wow_object.emote!(self)
    end
  end
end
