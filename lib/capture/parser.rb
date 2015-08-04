module WOW::Capture
  class Parser
    module FormatVersions
      V2_1 = 0x201
      V2_2 = 0x202
      V3_0 = 0x300
      V3_1 = 0x301
    end

    CLIENT_BUILDS = [20338, 20253]

    DIRECTIONS = ['CMSG', 'SMSG']

    def initialize(path, opts = {})
      @file = File.open(path, 'rb')

      @objects = ObjectStorage.new(self)
      @session = SessionStorage.new
      @combat_sessions = CombatSessionStorage.new(self)

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

      read_header
      ensure_supported_client
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

    # Checks if the capture's build is in the set of supported client builds.
    private def ensure_supported_client
      raise "Unsupported client build: #{@client_build}" if !CLIENT_BUILDS.include?(@client_build)
    end

    # Identifies a stub to a module appropriate for the client build of this capture. May not be an
    # exact match if the definitions didn't change between builds -- as is common with hotfix
    # releases.
    private def select_definitions
      truncated_builds = CLIENT_BUILDS.select { |build| build <= @client_build }.sort.reverse

      # Find the first existing module walking down from the actual build.
      truncated_builds.each do |potential_match|
        definitions = WOW::Capture::Definitions.for_build(potential_match)
        @definitions = definitions if !definitions.nil?
      end

      raise "Unable to identify appropriate definitions: #{@client_build}" if @definitions.nil?
    end

    # Read the capture header.
    private def read_header
      @magic = read_char(3)
      @format_version = read_uint16
      @sniffer_id = read_char(1)
      @client_build = read_uint32
      @client_locale = read_char(4)
      @session_key = read_char(40)
      @start_time = Time.at(read_uint32)
      @start_tick = read_uint32

      hello_length = read_uint32
      @sniffer_hello = read_char(hello_length)
    end

    # Read a single packet.
    private def read_packet
      direction = read_char(4)
      connection_index = read_int32
      tick = read_uint32
      time = @start_time + ((tick - @start_tick) / 1000.0)
      extra_length = read_int32
      length = read_int32
      read_char(extra_length)
      opcode = read_int32
      data = read_char(length - 4)

      packet_class = opcode_to_packet_class(direction, opcode)
      packet = packet_class.new(self, @packet_index, direction, connection_index, tick, time, data)

      @packet_index += 1

      packet
    end

    private def read_char(length)
      @file.read(length)
    end

    private def read_uint32
      @file.read(4).unpack('V').first
    end

    private def read_int32
      @file.read(4).unpack('i<').first
    end

    private def read_uint16
      @file.read(2).unpack('s<').first
    end

    private def read_float
      @file.read(4).unpack('e').first
    end

    private def read_string
      string = ''

      loop do
        character = @file.read(1)
        break if character == "\x00" || character.nil?
        string << character
      end

      string
    end

    private def valid_direction?(direction)
      DIRECTIONS.include?(direction)
    end

    private def opcode_to_packet_class(direction, opcode)
      return Packets::Invalid if !valid_direction?(direction)

      opcode_entry = defs.opcodes[direction.downcase][opcode]

      if opcode_entry.nil? || opcode_entry.value == :Unhandled
        packet_module = Packets
        packet_class_name = Packets::UNHANDLED_PACKET_CLASS_NAME
      else
        packet_module = Packets.const_get(direction)
        packet_class_name = opcode_entry.value
      end

      packet_class = packet_module.const_get(packet_class_name)

      packet_class
    end
  end
end
