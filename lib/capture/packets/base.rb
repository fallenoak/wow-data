module WOW::Capture::Packets
  class Base
    attr_reader :parser, :opcode, :index, :direction, :connection_index, :tick, :time,
      :elapsed_time, :references

    def initialize(parser, opcode, index, direction, connection_index, tick, time, elapsed_time, data)
      @parser = parser
      @opcode = opcode
      @index = index
      @direction = direction
      @connection_index = connection_index
      @tick = tick
      @time = time
      @elapsed_time = elapsed_time

      @references = []

      @_data = StringIO.new(data)

      @_bitpos = 8
      @_curbitval = nil

      parse!
      track_references!
      update_state!
    end

    private def add_reference!(reference_label, reference_type, entry_type, entry_id)
      @references << WOW::Capture::Utility::Reference.new(@index, reference_label, reference_type, entry_type, entry_id)
    end

    def has_references?
      @references.length > 0
    end

    def handled?
      true
    end

    def valid?
      true
    end

    def parse!
    end

    private def track_references!
    end

    private def update_state!
    end

    def pos
      @_data.pos
    end

    def pos=(new_pos)
      @_data.pos = new_pos
    end

    def read_bit
      @_bitpos += 1

      if @_bitpos > 7
        @_bitpos = 0
        @_curbitval = read_byte
      end

      value = ((@_curbitval >> (7 - @_bitpos)) & 1) != 0

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
      @_bitpos = 8
    end

    def read_uint64
      @_data.read(8).unpack('Q<').first
    end

    def read_int64
      @_data.read(8).unpack('q<').first
    end

    def read_uint32
      @_data.read(4).unpack('L<').first
    end

    def read_int32
      @_data.read(4).unpack('l<').first
    end

    def read_uint16
      @_data.read(2).unpack('S<').first
    end

    def read_int16
      @_data.read(2).unpack('s<').first
    end

    def read_float
      @_data.read(4).unpack('e').first
    end

    def read_packed_guid128
      guid_low_mask = read_byte
      guid_high_mask = read_byte

      guid_low = read_packed_uint64(guid_low_mask)
      guid_high = read_packed_uint64(guid_high_mask)

      guid = WOW::Capture::Guid128.new(parser, guid_low, guid_high)

      guid
    end

    def read_guid128
      guid_low = read_uint64
      guid_high = read_uint64

      guid = WOW::Capture::Guid128.new(parser, guid_low, guid_high)

      guid
    end

    def read_byte
      @_data.read(1).ord
    end

    def read_sbyte
      byte = @_data.read(1).ord

      # Signed byte, wraps around to -128 after +127. No native Ruby unpacker, so we need to
      # manually handle this.
      byte = 0 - (256 - byte) if byte > 127

      byte
    end

    def read_char(length)
      @_data.read(length)
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

    def read_update_block
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

    def read_string
      buffer = ''

      loop do
        char = read_char(1)
        break if char == "\x00" || char.nil?
        buffer << char
      end

      buffer
    end

    def inspect
      excluded_variables = [:@parser, :@_data, :@_bitpos, :@_curbitval]
      all_variables = instance_variables
      variables = all_variables - excluded_variables

      prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

      parts = []

      variables.each do |var|
        parts << "#{var}=#{instance_variable_get(var).inspect}"
      end

      str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

      str
    end
  end
end
