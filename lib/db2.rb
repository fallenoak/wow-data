module WOW
  class DB2
    attr_reader :record_count, :field_count, :record_size, :string_table_size, :records, :build,
      :min_id, :max_id, :locale

    def initialize(path, opts = {})
      @file = File.open(path, 'rb')

      @filename = path.split('/').last

      @header_size = 48
      @index_size = nil

      @magic = nil
      @record_count = nil
      @field_count = nil
      @record_size = nil
      @string_table_start = nil
      @string_table_size = nil
      @table_hash = nil
      @build = nil
      @timestamp_last_written = nil
      @min_id = nil
      @max_id = nil
      @locale = nil
      @unk1 = nil

      @index = {}

      @records = []

      read_header
      read_index

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
      @string_table_size = read_uint32
      @table_hash = read_uint32
      @build = read_uint32
      @timestamp_last_written = read_uint32
      @min_id = read_uint32
      @max_id = read_uint32
      @locale = read_uint32
      @unk1 = read_uint32

      @index_size = (((@max_id - @min_id) + 1) * 4) + (((@max_id - @min_id) + 1) * 2)

      @string_table_start = @header_size + @index_size + (@record_size * @record_count)
    end

    private def read_index
      index_entries_count = (@max_id - @min_id) + 1

      cursor = @min_id

      index_entries_count.times do
        record_offset = read_uint32
        @index[cursor] = record_offset
        cursor += 1
      end

      index_entries_count.times do
        read_char(2)
      end
    end

    private def read_record
      record = Records.const_get(record_class_name).new(read_fields)

      @records << record

      # Ensure we return the record.
      record
    end

    private def read_fields
      fields = {}

      Records.const_get(record_class_name).const_get(:STRUCTURE).each do |field_definition|
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

      @file.pos = @string_table_start + offset

      string = ''

      loop do
        character = @file.read(1)
        break if character == "\x00" || character.nil?
        string << character
      end

      @file.pos = saved_pos

      string
    end

    private def record_class_name
      name = @filename.split('.').first

      # Ensure first letter is capitalized-- not all files have uppercased first letters.
      name = name[0, 1].upcase + name[1, name.length] if name[0, 1].downcase == name[0, 1]

      # Any dashes or underscores should be removed, and the following letter upcased.
      name.gsub!(/([\-|_])([a-zA-Z0-9])/) do |match|
        match = "#{$2.upcase}"
      end

      name
    end
  end
end
