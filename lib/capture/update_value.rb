module WOW::Capture
  class UpdateValue
    attr_reader :value, :type, :size

    def initialize(parser, type, size, blocks)
      @parser = parser

      @type = type
      @size = size
      @blocks = blocks

      parse!
    end

    def []=(index, value)
      raise ArgumentError.new('out of range') if index > @size - 1 || index < 0

      @blocks[index] = value

      parse!
    end

    private def parse!
      @data = StringIO.new(@blocks.pack('I<*'))
      @value = send("read_#{type}")
    end

    private def read_uint64
      @data.read(8).unpack('Q<').first
    end

    private def read_int64
      @data.read(8).unpack('q<').first
    end

    private def read_uint32
      @data.read(4).unpack('L<').first
    end

    private def read_int32
      @data.read(4).unpack('l<').first
    end

    private def read_uint16
      @data.read(2).unpack('S<').first
    end

    private def read_int16
      @data.read(2).unpack('s<').first
    end

    private def read_float
      @data.read(4).unpack('e').first
    end

    def read_byte
      @data.read(1).ord
    end

    private def read_guid128
      guid_low = read_uint64
      guid_high = read_uint64

      guid = WOW::Capture::Guid128.new(@parser, guid_low, guid_high)

      guid
    end
  end
end
