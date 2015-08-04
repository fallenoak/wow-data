module WOW::Capture::WOWObject::Utility::LogItems
  class Update < Base
    attr_reader :delta

    def type
      :update
    end

    def parse!
      @delta = @extras[:delta]
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Attributes: #{@delta.count}"

      @delta.each do |entry|
        output << pretty_line
        output << " Update:     #{entry.attribute_name}: #{entry.old_value} -> #{entry.new_value}"
      end

      output
    end
  end
end
