module WOW::Capture::WOWObject::Utility::LogItems
  class Chat < Base
    attr_reader :text, :sender_name, :channel_name

    def type
      :chat
    end

    def parse!
      @sender_name = @packet.sender_name
      @channel_name = @packet.channel_name
      @text = @packet.text
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Channel: [#{@channel_name}]" if !@channel_name.to_s.empty?
      output << " Sender: [#{@sender_name}]" if !@sender_name.to_s.empty?
      output << " Text: #{@text}"

      output
    end
  end
end
