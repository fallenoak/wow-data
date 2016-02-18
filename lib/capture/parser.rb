module WOW::Capture
  class Parser
    PKT_FORMAT_VERSIONS = {
      0x201 => :v2_1,
      0x202 => :v2_2,
      0x300 => :v3_0,
      0x301 => :v3_1
    }

    PKT_MAGIC_HEADER = 'PKT'.freeze

    BIN_FORMAT_EXT = 'bin'.freeze

    DIRECTIONS = %i(CMSG SMSG BNC BNS)

    DIRECTION_MAP = {
      'CMSG'.freeze => :CMSG,
      'SMSG'.freeze => :SMSG,
      'BN_C'.freeze => :BNC,
      'BN_S'.freeze => :BNS,
      0 => :CMSG,
      1 => :SMSG
    }

    MIN_START_TIME = Time.utc(2005, 1, 1, 0, 0, 0)
    MAX_START_TIME = Time.utc(2020, 12, 31, 23, 59, 59)

    attr_reader :type, :format_version, :client_build, :client_locale, :start_time, :packet_index

    def initialize(path, opts = {})
      file_name = path.split('/').last
      file_extension = file_name.split('.').last.downcase.strip

      if file_extension == BIN_FORMAT_EXT
        @type = :bin
      else
        @type = :pkt
      end

      @file = File.open(path, 'rb')

      setup_storage

      @headerless = true

      @magic = nil
      @format_version = nil
      @sniffer_id = nil

      @client_build = nil
      @client_locale = nil

      @session_key = nil
      @start_time = nil
      @start_tick = nil

      @sniffer_hello = nil

      @packet_index = 0

      @packet_start = 0

      @subscriptions = {}

      read_pkt_header if @type == :pkt
      guess_build if headerless?

      validate_start_time
      validate_client_build

      select_definitions
    end

    # Returns a stub to the module appropriate for the client build of this capture.
    def definitions
      @definitions
    end
    alias_method :defs, :definitions

    # Returns the instance of ObjectStorage used by this parser instance.
    def objects
      @objects
    end

    def session
      @session
    end

    def combat_sessions
      @combat_sessions
    end

    private def setup_storage
      @objects = ObjectStorage.new(self)
      @session = SessionStorage.new
      @combat_sessions = CombatSessionStorage.new(self)
    end

    def on(event_name, filters = {}, &block)
      if !@subscriptions.has_key?(event_name)
        @subscriptions[event_name] = []
      end

      @subscriptions[event_name] << [block, filters]
    end

    def publish(event_name, payload = nil, filters = {})
      return if !@subscriptions.has_key?(event_name)

      matching_subscriptions = @subscriptions[event_name].select { |s| s[1].empty? || s[1] == filters }

      matching_subscriptions.each do |subscription|
        if payload.nil?
          subscription[0].call
        else
          subscription[0].call(payload)
        end
      end
    end

    def next_packet
      read_packet
    end

    def close
      @file.close
    end

    def eof?
      @file.eof?
    end

    # Drives the parser across all packets within the capture. Useful when relying on event
    # subscriptions to process the capture.
    def replay!
      next_packet while !eof?
    end

    def rewind!
      @file.pos = @packet_start

      # Wipe storage since we're presumably going to run through packets again.
      setup_storage
    end

    def headerless?
      @headerless == true
    end

    # Identifies a stub to a module appropriate for the client build of this capture. May not be an
    # exact match if the definitions didn't change between builds -- as is common with hotfix
    # releases.
    private def select_definitions
      @definitions = WOW::Definitions.for_build(@client_build, merged: true)
      raise "Unable to identify appropriate definitions: #{@client_build}" if @definitions.nil?
    end

    # Read a .pkt file header.
    private def read_pkt_header
      @magic = read_string(3)

      # Headerless capture.
      if @magic != PKT_MAGIC_HEADER
        @packet_start = 0
        @headerless = true

        rewind!

        return
      end

      @headerless = false

      @format_version = PKT_FORMAT_VERSIONS[read_uint16]

      case @format_version
      when :v3_0
        read_pkt_v3_0_header
      when :v3_1
        read_pkt_v3_1_header
      end
    end

    private def read_pkt_v3_0_header
      @sniffer_id = read_string(1).ord

      @client_build = read_uint32
      @client_locale = read_string(4)
      @session_key = read_string(40)

      additional_length = read_int32

      pre_pos = @file.pos

      read_string(additional_length)

      post_pos = @file.pos

      # Xyla
      if @sniffer_id == 10
        @file.pos = pre_pos

        @start_time = Time.at(read_uint32)
        @start_tick = read_uint32

        @file.pos = post_pos
      end
    end

    private def read_pkt_v3_1_header
      @sniffer_id = read_string(1).ord

      @client_build = read_uint32
      @client_locale = read_string(4)
      @session_key = read_string(40)

      @start_time = Time.at(read_uint32)
      @start_tick = read_uint32

      hello_length = read_uint32
      @sniffer_hello = read_string(hello_length)

      @packet_start = @file.pos
    end

    # Read a single packet.
    private def read_packet
      raise EOFError.new if @file.eof?

      case @type
      when :pkt
        read_pkt_packet
      else
        read_bin_packet
      end
    end

    private def read_pkt_packet
      case @format_version
      when :v2_1
        read_pkt_v2_1_packet
      when :v2_2
        read_pkt_v2_2_packet
      when :v3_0
        read_pkt_v3_0_packet
      when :v3_1
        read_pkt_v3_1_packet
      else
        read_pkt_default_packet
      end
    end

    private def read_pkt_v3_0_packet
      direction = DIRECTION_MAP[read_string(4)]

      time = Time.at(read_int32)
      tick = read_uint32

      extra_length = read_int32
      length = read_int32

      extra_data = read_string(extra_length)

      opcode = read_int32

      validate_packet_length(length)
      validate_packet_direction(direction)

      elapsed_time = @start_time - time

      connection_index = nil

      data = read_string(length - 4)

      packet_class, opcode_entry = lookup_opcode(direction, opcode)

      header_attributes = {
        index: @packet_index,
        connection_index: connection_index,

        tick: tick,
        time: time,
        elapsed_time: elapsed_time,

        direction: direction,
        opcode: opcode_entry
      }

      packet = packet_class.new(self, header_attributes, data)

      @packet_index += 1

      publish(:packet, packet, direction: direction, opcode: opcode_entry)

      packet
    end

    private def read_pkt_v3_1_packet
      direction = DIRECTION_MAP[read_string(4)]
      connection_index = read_int32
      tick = read_uint32
      extra_length = read_int32
      length = read_int32
      extra_data = read_string(extra_length)
      opcode = read_int32

      validate_packet_length(length)
      validate_packet_direction(direction)

      elapsed_time = (tick - @start_tick) / 1000.0
      time = @start_time + elapsed_time

      data = read_string(length - 4)

      packet_class, opcode_entry = lookup_opcode(direction, opcode)

      header_attributes = {
        index: @packet_index,
        connection_index: connection_index,

        tick: tick,
        time: time,
        elapsed_time: elapsed_time,

        direction: direction,
        opcode: opcode_entry
      }

      packet = packet_class.new(self, header_attributes, data)

      @packet_index += 1

      publish(:packet, packet, direction: direction, opcode: opcode_entry)

      packet
    end

    private def read_pkt_default_packet
      opcode = read_uint16
      length = read_int32
      direction = DIRECTION_MAP[read_uint8]
      time = Time.at(read_int64)

      validate_packet_length(length)
      validate_packet_direction(direction)

      elapsed_time = @start_time.nil? ? 0 : time - @start_time
      data = read_string(length)

      connection_index = nil
      tick = nil

      packet_class, opcode_entry = lookup_opcode(direction, opcode)

      header_attributes = {
        index: @packet_index,
        connection_index: connection_index,

        tick: tick,
        time: time,
        elapsed_time: elapsed_time,

        direction: direction,
        opcode: opcode_entry
      }

      packet = packet_class.new(self, header_attributes, data)

      @packet_index += 1

      publish(:packet, packet, direction: direction, opcode: opcode_entry)

      packet
    end

    private def read_bin_packet
      opcode = read_int32
      length = read_int32
      time = Time.at(read_int32)
      direction = DIRECTION_MAP[read_uint8]

      validate_packet_length(length)
      validate_packet_direction(direction)

      elapsed_time = @start_time.nil? ? 0 : time - @start_time
      data = read_string(length)

      connection_index = nil
      tick = nil

      packet_class, opcode_entry = lookup_opcode(direction, opcode)

      header_attributes = {
        index: @packet_index,
        connection_index: connection_index,

        tick: tick,
        time: time,
        elapsed_time: elapsed_time,

        direction: direction,
        opcode: opcode_entry
      }

      packet = packet_class.new(self, header_attributes, data)

      @packet_index += 1

      publish(:packet, packet, direction: direction, opcode: opcode_entry)

      packet
    end

    def create_inline_packet(parent, opcode, data_or_stream)
      direction = parent.header.direction
      connection_index = parent.header.connection_index
      tick = parent.header.tick

      elapsed_time = parent.header.elapsed_time
      time = parent.header.time

      packet_class, opcode_entry = lookup_opcode(direction, opcode)

      header_attributes = {
        index: parent.header.index,
        connection_index: connection_index,

        tick: tick,
        time: time,
        elapsed_time: elapsed_time,

        direction: direction,
        opcode: opcode_entry
      }

      packet = packet_class.new(self, header_attributes, data_or_stream)

      publish(:packet, packet, direction: direction, opcode: opcode_entry)

      packet
    end

    private def read_uint8
      @file.read(1).ord
    end

    private def read_int64
      @file.read(8).unpack('q<').first
    end

    private def read_uint32
      @file.read(4).unpack('L<').first
    end

    private def read_int32
      @file.read(4).unpack('i<').first
    end

    private def read_uint16
      @file.read(2).unpack('S<').first
    end

    private def read_float
      @file.read(4).unpack('e').first
    end

    private def read_string(length)
      @file.read(length)
    end

    private def read_cstring
      string = ''

      loop do
        character = @file.read(1)
        break if character == "\x00" || character.nil?
        string << character
      end

      string
    end

    private def lookup_opcode(direction, opcode)
      if defs.nil? || !defs.respond_to?(:opcodes) || defs.opcodes[direction.downcase].nil?
        return [Packets::Unhandled, nil]
      end

      opcode_entry = defs.opcodes[direction.downcase][opcode]

      if opcode_entry.nil? || opcode_entry.value == :Unhandled
        return [Packets::Unhandled, opcode_entry]
      end

      packet_module = Packets.const_get(direction)
      packet_class_name = opcode_entry.value

      if !packet_module.const_defined?(packet_class_name)
        return [Packets::Unhandled, opcode_entry]
      end

      packet_class = packet_module.const_get(packet_class_name)

      [packet_class, opcode_entry]
    end

    # Based on the timestamp of the first packet, guess which client build produced this capture.
    private def guess_build
      packet_specimen = read_packet
      captured_at = packet_specimen.header.time
      @start_time = captured_at

      # Find the client build known to have been in use at the capture time.
      guessed_build = WOW::ClientBuilds.in_use_at(captured_at)
      @client_build = guessed_build

      # Reset the file position to 0.
      rewind!
    end

    private def validate_packet_direction(direction)
      if direction.nil? || !DIRECTIONS.include?(direction)
        raise WOW::Capture::Errors::FormatError.new("Capture file has packet with invalid" <<
          " direction: #{direction}")
      end
    end

    private def validate_packet_length(length)
      if length < 0
        raise WOW::Capture::Errors::FormatError.new("Capture file has packet with negative" <<
          " length: #{length}")
      end
    end

    # Ensure the capture start time appears within a valid range.
    private def validate_start_time
      if @start_time < MIN_START_TIME || @start_time > MAX_START_TIME
        raise WOW::Capture::Errors::FormatError.new("Capture file has packet timestamp outside" <<
          " of expected range: #{@start_time}")
      end
    end

    # Checks if the capture's build is in the set of known client builds.
    private def validate_client_build
      if !WOW::ClientBuilds.known?(@client_build)
        raise WOW::Capture::Errors::UnknownClientError.new("Unknown client build:" <<
          " #{@client_build}")
      end
    end
  end
end
