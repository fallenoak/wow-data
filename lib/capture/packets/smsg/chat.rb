module WOW::Capture::Packets::SMSG
  class Chat < WOW::Capture::Packets::Base
    attr_reader :slash_cmd, :language, :sender_guid, :sender_guild_guid, :target_guid, :party_guid,
      :achievement_id, :chat_flags, :sender_name, :receiver_name, :channel_name, :text

    def parse!
      @slash_cmd = read_byte
      @language = read_byte
      @sender_guid = read_packed_guid128

      @sender_guild_guid = read_packed_guid128
      @wow_account_guid = read_packed_guid128
      @target_guid = read_packed_guid128

      @target_virtual_address = read_uint32
      @sender_virtual_address = read_uint32

      @party_guid = read_packed_guid128

      @achievement_id = read_uint32
      @display_time = read_float

      sender_name_len = read_bits(11)
      receiver_name_len = read_bits(11)
      prefix_len = read_bits(5)
      channel_len = read_bits(7)
      text_len = read_bits(12)

      # 10 bits before 19802, 11 bits in and after build 19802
      @chat_flags = read_bits(11)

      hide_chat_log = read_bit
      fake_sender_name = read_bit

      @sender_name = read_char(sender_name_len)
      @receiver_name = read_char(receiver_name_len)
      @addon_message_prefix = read_char(prefix_len)
      @channel_name = read_char(channel_len)
      @text = read_char(text_len)
    end

    private def update_wow_objects!
      # Targets might not be loaded yet, such as in the case of zone-wide yells referencing a
      # different player when they turned in a quest.
      target = parser.objects.find_or_create(@target_guid)

      sender = parser.objects.find_or_create(@sender_guid)
      sender.chat!(self)
    end
  end
end
