module WOW::ADT::Records
  class Base
    attr_reader :type

    def initialize(type, data)
      @type = type.to_sym
      @data = StringIO.new(data)

      parse
    end

    def parse
    end

    private def read_uint32
      @data.read(4).unpack('V').first
    end

    private def read_float
      @data.read(4).unpack('e').first
    end
  end
end
