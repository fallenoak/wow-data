module WOW
  class Stream
    def initialize(data_or_stream = nil)
      if data_or_stream.nil?
        @stream = StringIO.new
      elsif data_or_stream.is_a?(String)
        @stream = StringIO.new(data_or_stream)
      elsif data_or_stream.is_a?(StringIO) || data_or_stream.is_a?(IO)
        @stream = data_or_stream
      else
        raise Errors::UnsupportedFormat.new
      end
    end

    def close
      @stream.close
    end

    def pos
      @stream.pos
    end

    def pos=(new_pos)
      @stream.pos = new_pos
    end

    def last_pos
      @stream.size
    end

    def size
      @stream.size
    end

    def eof?
      @stream.eof?
    end

    def rewind
      @stream.rewind
    end

    def write(data)
      @stream.write(data)
    end

    def read(length = nil)
      @stream.read(length)
    end

    def read_char(length = nil)
      if length.nil?
        str = ''

        loop do
          char = @stream.read(1)
          break if char == "\x00"
          str << char
        end
      else
        str = read_bytes(length)
      end

      str
    end

    def read_bytes(length)
      @stream.read(length)
    end

    def read_hex(length)
      @stream.read(length).unpack('H*')[0]
    end

    def read_uint16be
      @stream.read(2).unpack('S>')[0]
    end

    def read_uint16le
      @stream.read(2).unpack('S<')[0]
    end

    def read_uint24be
      bytes = @stream.read(3)

      combined = bytes[2].ord | (bytes[1].ord << 8) | (bytes[0].ord << 16)
      combined |= 0xFF000000 if combined & 0x800000 != 0

      combined
    end

    def read_int32le
      @stream.read(4).unpack('l<')[0]
    end

    def read_uint32be
      @stream.read(4).unpack('L>')[0]
    end

    def read_uint32le
      @stream.read(4).unpack('L<')[0]
    end

    def read_uint64be
      @stream.read(8).unpack('Q>')[0]
    end

    def read_uint64le
      @stream.read(8).unpack('Q<')[0]
    end

    def read_uint8
      @stream.read(1).ord
    end
  end
end
