module WOW::Capture::WOWObject::Utility::LogItems
  class Move < Base
    attr_reader :from, :to

    def type
      :move
    end

    def parse!
      @from = object.current_position
      @to = packet.record.position
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " From: #{@from.pretty_print}"
      output << pretty_line
      output << " To:   #{@to.pretty_print}"

      output
    end
  end
end
