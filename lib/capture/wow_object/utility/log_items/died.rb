module WOW::Capture::WOWObject::Utility::LogItems
  class Died < Base
    def type
      :died
    end

    def parse!
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      #output << " Channel: [#{@channel_name}]" if !@channel_name.to_s.empty?
      #output << " Sender: [#{@sender_name}]" if !@sender_name.to_s.empty?
      #output << " Text: #{@text}"

      output
    end
  end
end
