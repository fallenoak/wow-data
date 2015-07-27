module WOW::Capture::Packets
  class Base
    attr_reader :direction, :connection_index, :tick, :time, :data

    def initialize(direction, connection_index, tick, time, data)
      @direction = direction
      @connection_index = connection_index
      @tick = tick
      @time = time

      @data = StringIO.new(data)

      parse!
    end

    def handled?
      true
    end

    def valid?
      true
    end

    def parse!
    end

    private def read_float
      @data.read(4).unpack('e').first
    end

    private def read_guid128
      guid_low_mask = read_byte
      guid_high_mask = read_byte

      guid_low = read_packed_uint64(guid_low_mask)
      guid_high = read_packed_uint64(guid_high_mask)

      guid = WOW::Capture::Guid128.new(guid_low, guid_high)

      guid
    end

    private def read_byte
      @data.read(1).ord
    end

    private def read_packed_uint64(mask)
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
  end
end
