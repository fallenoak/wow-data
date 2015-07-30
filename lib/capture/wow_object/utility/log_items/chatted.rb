module WOW::Capture::WOWObject::Utility::LogItems
  class Chatted < Base
    attr_reader :text

    def type
      :chatted
    end

    def parse!
      @text = @packet.text
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Text: #{@text}"

      output
    end
  end
end
