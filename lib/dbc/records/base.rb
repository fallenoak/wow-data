module WOW::DBC::Records
  class Base
    attr_reader :fields

    def initialize(fields)
      @fields = fields
    end

    private def method_missing(method_name)
      @fields[method_name.to_sym]
    end
  end
end
