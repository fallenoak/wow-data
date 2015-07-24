module WOW::ADT::Records
  class Base
    def initialize(data)
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
