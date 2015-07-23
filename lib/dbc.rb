module WOW
  class DBC
    attr_reader :record_count, :field_count, :record_size, :string_block_size, :records

    def initialize(path, opts = {})
      @file = File.open(path, 'rb')

      @filename = path.split('/').last

      set_template

      @header_size = 20
      @magic = nil
      @record_count = nil
      @field_count = nil
      @record_size = nil
      @string_block_start = nil
      @string_block_size = nil

      @records = []

      read_header

      # If we're not in lazy mode, read all records now.
      read_record until eof? if opts[:lazy] == false
    end

    def close
      @file.close
    end

    def eof?
      @file.pos >= @header_size + (@record_size * @record_count)
    end

    def next_record
      read_record
    end

    private def read_header
      @magic = read_char(4)
      @record_count = read_uint32
      @field_count = read_uint32
      @record_size = read_uint32
      @string_block_size = read_uint32
      @string_block_start = @header_size + (@record_size * @record_count)
    end

    private def read_record
      record = Record.new(@template, read_fields)

      @records << record

      # Ensure we return the record.
      record
    end

    private def read_fields
      fields = {}

      @template.const_get(:STRUCTURE).each do |field_definition|
        field_type, field_name = field_definition
        fields[field_name] = send("read_#{field_type}")
      end

      fields
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

    private def read_float
      @file.read(4).unpack('e').first
    end

    private def read_string
      offset = read_uint32

      saved_pos = @file.pos

      @file.pos = @string_block_start + offset

      string = ''

      loop do
        character = @file.read(1)
        break if character == "\x00" || character.nil?
        string << character
      end

      @file.pos = saved_pos

      string
    end

    private def set_template
      template_name = @filename.split('.').first.capitalize
      @template = Templates.const_get(template_name)
    end
  end
end
