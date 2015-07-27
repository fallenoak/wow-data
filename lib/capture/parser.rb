module WOW::Capture
  class Parser
    module FormatVersions
      V2_1 = 0x201
      V2_2 = 0x202
      V3_0 = 0x300
      V3_1 = 0x301
    end

    def initialize(path, opts = {})
      @file = File.open(path, 'rb')

      @magic = nil
      @format_version = nil
      @sniffer_id = nil

      @client_build = nil
      @client_locale = nil

      @session_key = nil
      @start_time = nil
      @start_tick = nil

      @sniffer_hello = nil

      read_header
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

      packet_class_name = opcode_to_packet_class_name(opcode)

      packet = Packets.const_get(packet_class_name).new(direction, connection_index, tick, time, data)

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

    private def opcode_to_packet_class_name(opcode)
      directory_entry = Opcodes::DIRECTORY[opcode]
      directory_entry.nil? ? 'Unparsed' : directory_entry.last
    end
  end
end
