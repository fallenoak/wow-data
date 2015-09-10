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

        update_prefix = " Update:     #{entry.attribute_name}: "

        output << update_prefix

        if entry.old_value.respond_to?(:pretty_print)
          output << "#{entry.old_value.pretty_print} ->"
          output << pretty_line
          output << " " * update_prefix.length
          output << "#{entry.new_value.pretty_print}"
        else
          output << "#{entry.old_value.inspect} -> #{entry.new_value.inspect}"
        end

        if !entry.difference.nil?
          output << " (#{entry.difference})"
        end
      end

      output
    end
  end
end
