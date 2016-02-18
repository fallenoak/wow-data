module WOW::Capture
  class Stream
    FORMAT_UINT16   = 'S<'.freeze
    FORMAT_INT16    = 's<'.freeze
    FORMAT_UINT32   = 'L<'.freeze
    FORMAT_INT32    = 'l<'.freeze
    FORMAT_UINT64   = 'Q<'.freeze
    FORMAT_INT64    = 'q<'.freeze
    FORMAT_FLOAT    = 'e'.freeze

    attr_reader :parser

    def initialize(parser, data)
      @parser = parser
      @client_build = parser.client_build

      @data = data.is_a?(String) ? StringIO.new(data) : data

      @bit_pos = 8
      @current_bit_value = nil
    end

    def length
      @data.length
    end

    def pos
      @data.pos
    end

    def pos=(new_pos)
      @data.pos = new_pos
    end

    def rewind!
      @data.pos = 0
    end

    def eof?
      @data.eof?
    end

    def client_build
      @client_build
    end

    def read_bit
      @bit_pos += 1

      if @bit_pos > 7
        @bit_pos = 0
        @current_bit_value = read_uint8
      end

      value = ((@current_bit_value >> (7 - @bit_pos)) & 1) != 0

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
      @bit_pos = 8
    end

    def read_uint64
      @data.read(8).unpack(FORMAT_UINT64).first
    end

    def read_int64
      @data.read(8).unpack(FORMAT_INT64).first
    end

    def read_uint32
      @data.read(4).unpack(FORMAT_UINT32).first
    end

    def read_int32
      @data.read(4).unpack(FORMAT_INT32).first
    end

    def read_uint16
      @data.read(2).unpack(FORMAT_UINT16).first
    end

    def read_int16
      @data.read(2).unpack(FORMAT_INT16).first
    end

    def read_uint8
      @data.read(1).ord
    end

    def read_int8
      byte = @data.read(1).ord

      # Signed byte, wraps around to -128 after +127. No native Ruby unpacker, so we need to
      # manually handle this.
      byte = 0 - (256 - byte) if byte > 127

      byte
    end

    def read_float
      @data.read(4).unpack(FORMAT_FLOAT).first
    end

    def read_guid64
      guid_low = read_uint64

      WOW::Capture::Utility::GuidManager.fetch_guid64(@parser, guid_low)
    end

    def read_packed_guid64
      guid_low = read_packed_uint64

      WOW::Capture::Utility::GuidManager.fetch_guid64(@parser, guid_low)
    end

    def read_guid128
      guid_low = read_uint64
      guid_high = read_uint64

      WOW::Capture::Utility::GuidManager.fetch_guid128(@parser, guid_low, guid_high)
    end

    def read_packed_guid128
      guid_low_mask = read_uint8
      guid_high_mask = read_uint8

      guid_low = read_packed_uint64(guid_low_mask)
      guid_high = read_packed_uint64(guid_high_mask)

      WOW::Capture::Utility::GuidManager.fetch_guid128(@parser, guid_low, guid_high)
    end

    def read_all
      @data.read(@data.length - @data.pos)
    end

    def read_inflate(opts = {})
      deflated_length = opts[:deflated_length]
      inflated_length = opts[:inflated_length]
      preserve_context = opts[:preserve_context].nil? ? true : opts[:preserve_context]

      if deflated_length.nil?
        buffer = read_all
      else
        buffer = read_string(deflated_length)
      end

      # Client builds after 15005 seem to NOT maintain Zlib state between compressed packets.
      # Client builds including and before 15005 seem to maintain Zlib state between compressed
      # packets.
      #
      # TODO: There's a lot more at play with compression state, including the distinct possibility
      # older captures with packets with compressed data will simply never be fully decompressed.
      if @client_build > 15005 || !preserve_context
        inflater = Zlib::Inflate.new

        if !inflated_length.nil?
          inflater.avail_out = inflated_length
        end

        begin
          value = inflater.inflate(buffer)
        rescue => e
          value = ''
        end

        inflater.close
      else
        value = @parser.zmanager.inflate(buffer, inflated_length)
      end

      value
    end

    def read_string(length)
      @data.read(length)
    end

    def read_cstring
      buffer = ''

      loop do
        char = read_string(1)
        break if char == "\x00" || char.nil?
        buffer << char
      end

      buffer
    end

    def read_packed_uint64(mask = nil)
      mask = read_uint8 if mask.nil?
      return 0 if mask == 0

      res = 0
      i = 0

      while i < 8 do
        if (mask & 1 << i) != 0
          res += read_uint8 << (i * 8)
        end

        i += 1
      end

      res
    end

    def read_time
      time = read_int32

      Time.at(time)
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

    def read_vector(length)
      vector = []

      length.times do
        vector << read_float
      end

      vector
    end

    def read_coord(length)
      vector = read_vector(length)

      WOW::Capture::Types::Coordinate.new(vector)
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

      [x, y, z, w]
    end

    def read_bool
      read_uint8 != 0
    end

    def read_bitstream_guid64(start_values, parse_values)
      guid_low = read_bitstream_uint64(start_values, parse_values)

      WOW::Capture::Utility::GuidManager.fetch_guid64(@parser, guid_low)
    end

    def read_bitstream_uint64(start_values, parse_values)
      bitstream = read_bitstream_start(start_values)

      read_bitstream_parse(bitstream, parse_values)

      value = bitstream.reverse.map { |v| sprintf('%02X' % v) }.join.to_i(16)

      value
    end

    def read_bitstream_start(values)
      bytes = []

      values.each do |value|
        bytes[value] = read_bit ? 1 : 0
      end

      bytes
    end

    def read_bitstream_parse(bitstream, values)
      temp_bytes = []

      i = 0

      values.each do |value|
        if bitstream[value] != 0
          bitstream[value] ^= read_uint8
        end

        i += 1

        temp_bytes[i] = bitstream[value]
      end

      temp_bytes
    end

    def read_bitarray(length)
      array_values = []

      length.times do
        array_values << read_uint32
      end

      BitArray.new(length, array_values)
    end

    def read_object_values(object_type)
      updates = {}

      object_fields = @parser.definitions.update_fields

      mask_size = read_uint8
      mask = read_bitarray(mask_size)

      fields_count = mask.total_set
      fields_found = 0
      field_index = 0
      previous_field_name = nil

      while fields_found < fields_count
        if mask[field_index] == 0
          field_index += 1
          next
        end

        field_lookup = WOW::Capture::Utility::ObjectFieldManager.
          lookup_field(object_fields, object_type, field_index)

        field_name, field_type, field_size, block_offset = field_lookup

        update = updates[field_name]

        if update.nil?
          update = WOW::Capture::Types::ObjectUpdate.new(field_type, field_size)
          updates[field_name] = update
        end

        block_value = read_uint32
        blocks_read = 1

        update[block_offset] = block_value

        field_index += blocks_read
        fields_found += blocks_read
      end

      if client_build >= 16016
        dynamic_updates = read_object_dynamic_values(object_type)
        updates.merge!(dynamic_updates)
      end

      updates
    end

    def read_object_dynamic_values(object_type)
      dynamic = {}

      mask_size = read_uint8
      mask = read_bitarray(mask_size)

      fields_count = mask.total_set
      fields_found = 0
      field_index = 0

      while fields_found < fields_count
        if mask[field_index] == 0
          field_index += 1
          next
        end

        flag = read_uint8

        if (flag & 0x80) != 0
          read_uint16
        end

        count = flag & 0x7F

        values = []

        count.times do
          values << read_uint32
        end

        field_index += 1
        fields_found += 1

        values_mask = BitArray.new(values.length, values)

        values_count = values_mask.total_set
        values_found = 0
        values_index = 0

        while values_found < values_count
          if values_mask[values_index] == 0
            values_index += 1
            next
          end

          block_value = read_uint32

          values_index += 1
          values_found += 1
        end
      end

      dynamic
    end

    def read_object_value_blocks
      blocks = []

      blocks << read_uint32 while !eof?

      blocks
    end

    def pretty_print(opts = {})
      cur_pos = @data.pos
      @data.pos = 0

      output = ''

      # Headers
      hex_headers = []
      ascii_headers = []

      16.times do |col|
        hex_headers << sprintf('%02x', col).upcase
        ascii_headers << sprintf('%x', col).upcase
      end

      hex_headers = hex_headers.join(' ')
      hex_width = hex_headers.length

      ascii_headers = ascii_headers.join(' ')
      ascii_width = ascii_headers.length

      header = hex_headers << ' | ' << ascii_headers

      row_width = header.length

      output << header
      output << "\n" << '-' * row_width

      # Bytes
      while !@data.eof?
        bytes = @data.read(16)

        hex_row = []
        ascii_row = []

        bytes.each_byte do |byte|
          hex_row << sprintf('%02x', byte).upcase
          ascii_row << ((32..254).include?(byte) ? byte.chr : '.')
        end

        output_row = sprintf("%-#{hex_width}s", hex_row.join(' ')) <<
          ' | ' << sprintf("%-#{ascii_width}s", ascii_row.join(' '))

        output << "\n" << output_row
      end

      @data.pos = cur_pos

      output
    end
  end
end
