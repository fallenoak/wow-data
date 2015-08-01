module WOW::Capture::Packets
  class Base
    attr_reader :parser, :index, :direction, :connection_index, :tick, :time

    def initialize(parser, index, direction, connection_index, tick, time, data)
      @parser = parser
      @index = index
      @direction = direction
      @connection_index = connection_index
      @tick = tick
      @time = time

      @data = StringIO.new(data)

      @bitpos = 8
      @curbitval = nil

      parse!
      update_state!
    end

    def handled?
      true
    end

    def valid?
      true
    end

    def parse!
    end

    def update_state!
    end

    def pos
      @data.pos
    end

    def pos=(new_pos)
      @data.pos = new_pos
    end

    def read_bit
      @bitpos += 1

      if @bitpos > 7
        @bitpos = 0
        @curbitval = read_byte
      end

      value = ((@curbitval >> (7 - @bitpos)) & 1) != 0

      value
    end

    def read_bits(length)
      value = 0

      (length - 1).downto(0) do |i|
        value |= 1 << i if read_bit
      end

      value
    end

    def reset_bit_reader
      @bitpos = 8
    end

    def read_int64
      @data.read(8).unpack('q<').first
    end

    def read_uint32
      @data.read(4).unpack('V').first
    end

    def read_int32
      @data.read(4).unpack('i<').first
    end

    def read_uint16
      @data.read(2).unpack('s<').first
    end

    def read_float
      @data.read(4).unpack('e').first
    end

    def read_packed_guid128
      guid_low_mask = read_byte
      guid_high_mask = read_byte

      guid_low = read_packed_uint64(guid_low_mask)
      guid_high = read_packed_uint64(guid_high_mask)

      guid = WOW::Capture::Guid128.new(guid_low, guid_high)

      guid
    end

    def read_byte
      @data.read(1).ord
    end

    def read_char(length)
      @data.read(length)
    end

    def read_packed_uint64(mask)
      return 0 if mask == 0

      res = 0
      i = 0

      while i < 8 do
        if (mask & 1 << i) != 0
          res += read_byte << (i * 8)
        end

        i += 1
      end

      res
    end

    def read_update_field
      read_uint32
    end

    def read_packed_time
      packed = read_int32

      minutes = packed & 0x3F
      hours = (packed >> 6) && 0x1F
      days = (packed >> 14) && 0x3F
      months = (packed >> 20) && 0xF
      years = (packed >> 24) && 0x1F

      base = Date.new(2000, 1, 1) >> (years * 12) >> months
      base = base.to_time
      base += (days * 24 * 60 * 60)
      base += (hours * 60 * 60)
      base += (minutes * 60)

      base
    end

    def read_vector(count)
      vector = []

      count.times do
        vector << read_float
      end

      vector
    end

    def read_packed_quaternion
      packed = read_int64

      x = (packed >> 42) * (1.0 / 2097152.0)
      y = (((packed << 22) >> 32) >> 11) * (1.0 / 1048576.0)
      z = (packed << 43 >> 43) * (1.0 / 1048576.0)

      w = (x * x) + (y * y) + (z * z)

      if (w - 1.0).abs >= (1.0 / 1048576.0)
        w = Math.sqrt((1.0 - w).abs)
      else
        w = 0.0
      end

      return [x, y, z, w]
    end
  end
end
