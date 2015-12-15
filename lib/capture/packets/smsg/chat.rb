module WOW::Capture::Packets::SMSG
  class Chat < WOW::Capture::Packets::Base
    HAS_SENDER_NAME =
      %i( monster_say monster_yell monster_party monster_emote monster_whisper raid_boss_emote
          raid_boss_whisper )

    HAS_RECEIVER_NAME =
      %i( battleground_neutral battleground_alliance battleground_horde monster_say monster_yell
          monster_party monster_emote monster_whisper raid_boss_emote raid_boss_whisper battlenet )

    HAS_RAID_EXTRAS =
      %i( raid_boss_emote raid_boss_whisper )

    HAS_ACHIEVEMENT_ID =
      %i( achievement guild_achievement battlenet )

    SENDERS_WITH_NAME =
      %i( creature vehicle game_object transport pet )

    RECEIVERS_WITH_NAME =
      %i( creature vehicle game_object transport )

    structure do
      build 19033 do
        int8      :message_type,            remap: :chat_message_types
        uint8     :language,                remap: :languages

        guid128   :sender_guid,             packed: true
        guid128   :sender_guild_guid,       packed: true
        guid128   :wow_account_guid,        packed: true
        guid128   :receiver_guid,           packed: true

        uint32    :receiver_virtual_address
        uint32    :sender_virtual_address

        guid128   :party_guid,              packed: true

        uint32    :achievement_id
        float     :display_time

        bits      :sender_name_length,      length: 11
        bits      :receiver_name_length,    length: 11
        bits      :addon_prefix_length,     length: 5
        bits      :channel_name_length,     length: 7
        bits      :text_length,             length: 12

        build 19802 do
          bits    :chat_flags,              length: 11
        end

        build 19033...19802 do
          bits    :chat_flags,              length: 10
        end

        bit       :hide_chat_log
        bit       :fake_sender_name

        string    :sender_name,             length: proc { sender_name_length }
        string    :receiver_name,           length: proc { receiver_name_length }
        string    :addon_prefix,            length: proc { addon_prefix_length }
        string    :channel_name,            length: proc { channel_name_length }
        string    :text,                    length: proc { text_length }
      end

      build 0..16357 do
        int8      :message_type,            remap: :chat_message_types
        int32     :language,                remap: :languages

        guid64    :sender_guid

        int32     :constant_time

        string    :channel_name,            if: proc { message_type == :channel }

        cond      if: proc {
                    HAS_SENDER_NAME.include?(message_type)
                  } do
                    int32   :sender_name_length
                    string  :sender_name
                  end

        guid64    :receiver_guid

        cond      if: proc {
                    HAS_RECEIVER_NAME.include?(message_type) &&
                    RECEIVERS_WITH_NAME.include?(receiver_guid.type)
                  } do
                    int32   :receiver_name_length
                    string  :receiver_name
                  end

        build 13914 do
          cond    if: proc { language == :addon } do
                    string  :addon_prefix
                  end
        end

        build 16357 do
          cond    if: proc { message_type == :raid || message_type == :raid_leader } do
                    uint32 :unknown_1
                    uint32 :unknown_2
                  end
        end

        int32     :text_length
        string    :text

        build 16309 do
          int16   :chat_tag
        end

        build 0...16309 do
          uint8   :chat_tag
        end

        build 14333 do
          cond    if: proc { HAS_RAID_EXTRAS.include?(message_type) } do
                    float   :unknown_3
                    uint8   :unknown_4
                  end
        end

        cond      if: proc { HAS_ACHIEVEMENT_ID.include?(message_type) } do
                    int32   :achievement_id
                  end
      end
    end

    private def track_references!
      if record.sender_guid.creature?
        add_reference!('Sender', :sender, :creature, record.sender_guid.entry_id)
      end

      if !record.receiver_guid.nil? && record.receiver_guid.creature?
        add_reference!('Receiver', :receiver, :creature, record.receiver_guid.entry_id)
      end
    end

    private def update_state!
      # Receiver might not be loaded yet, such as in the case of zone-wide yells referencing a
      # different player when they turned in a quest.
      if !record.receiver_guid.nil?
        target = parser.objects.find_or_create(record.receiver_guid)
      end

      sender = parser.objects.find_or_create(record.sender_guid)

      if record.language != :addon
        sender.chat!(self)
      end
    end
  end
end
