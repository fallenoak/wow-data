module WOW::Capture::WOWObject::Utility::LogItems
  class Chat < Base
    attr_reader :text, :sender_name, :channel_name

    def type
      :chat
    end

    def parse!
      @sender_name = packet.record.sender_name
      @channel_name = packet.record.channel_name
      @text = packet.record.text
    end

    def pretty_print
      output = ''

      output << pretty_prefix

      lines = []

      lines << " Channel: [#{@channel_name}]" if !@channel_name.to_s.empty?
      lines << " Sender:  [#{@sender_name}]" if !@sender_name.to_s.empty?
      lines << " Text:    #{@text}"

      output << lines.join(pretty_line)
    end
  end
end
