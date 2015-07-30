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

      update_wow_object
    end

    private def update_wow_object
      wow_object = parser.objects.find(@sender_guid)
      return if wow_object.nil?

      wow_object.chat!(self)
    end
  end
end

<<-eos

[Parser(Opcode.SMSG_CHAT)]
public static void HandleServerChatMessage(Packet packet)
{
    var bits24 = packet.ReadBits(11);
    var bits1121 = packet.ReadBits(11);
    var prefixLen = packet.ReadBits(5);
    var channelLen = packet.ReadBits(7);
    var textLen = packet.ReadBits(12);
    packet.ReadBits("ChatFlags", ClientVersion.AddedInVersion(ClientVersionBuild.V6_1_2_19802) ? 11 : 10);

    packet.ReadBit("HideChatLog");
    packet.ReadBit("FakeSenderName");

    text.SenderName = packet.ReadWoWString("Sender Name", bits24);
    text.ReceiverName = packet.ReadWoWString("Receiver Name", bits1121);
    packet.ReadWoWString("Addon Message Prefix", prefixLen);
    packet.ReadWoWString("Channel Name", channelLen);

    text.Text = packet.ReadWoWString("Text", textLen);

    uint entry = 0;
    if (text.SenderGUID.GetObjectType() == ObjectType.Unit)
        entry = text.SenderGUID.GetEntry();
    else if (text.ReceiverGUID.GetObjectType() == ObjectType.Unit)
        entry = text.ReceiverGUID.GetEntry();

    if (entry != 0)
        Storage.CreatureTexts.Add(entry, text, packet.TimeSpan);
}

eos
