module WOW::Capture::WOWObject::Utility::LogItems
  class Moved < Base
    attr_reader :from, :to

    def type
      :moved
    end

    def parse!
      @from = @object.current_position
      @to = @packet.position
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " From: #{@from.pretty_print}"
      output << " ==> To: #{@to.pretty_print}"

      output
    end
  end
end
