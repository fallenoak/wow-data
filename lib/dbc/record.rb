module WOW
  class DBC
    class Record
      attr_reader :fields

      def initialize(template, fields)
        @fields = fields
        extend(template)
        setup_attributes
      end

      private def method_missing(method_name)
        @fields[method_name.to_sym]
      end
    end
  end
end
