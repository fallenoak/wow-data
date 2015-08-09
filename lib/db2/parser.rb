module WOW::DB2
  class Parser
    attr_reader :record_count, :field_count, :record_size, :string_table_size, :records, :build,
      :min_id, :max_id, :locale, :string_table

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
      @string_table = StringIO.new('')

      @records = []

      read_header
      read_index
      read_string_table

      # Default to non-lazy.
      @lazy = opts[:lazy] == true

      # Default to cache.
      @cache = opts[:cache] != false

      # If we're not in lazy mode, read all records now.
      if !lazy?
        # Force caching in non-lazy mode.
        @cache = true

        read_record until eof?
        close
      end
    end

    def close
      @file.close
    end

    def eof?
      @file.pos >= @header_size + (@record_size * @record_count)
    end

    def lazy?
      @lazy == true
    end

    def cache?
      @cache == true
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
      @min_index = read_uint32
      @max_index = read_uint32
      @index_count = @max_index > 0 ? (@max_index - @min_index) + 1 : 0
      @locale = read_uint32
      @unk1 = read_uint32

      @index_size = (@index_count * 4) + (@index_count * 2)

      @string_table_start = @header_size + @index_size + (@record_size * @record_count)
    end

    private def read_index
      return if @index_size == 0

      cursor = @min_index

      @index_count.times do
        record_offset = read_uint32
        @index[cursor] = record_offset
        cursor += 1
      end

      @index_count.times do
        read_char(2)
      end
    end

    private def read_string_table
      saved_pos = @file.pos

      @file.pos = @string_table_start
      @string_table = StringIO.new(@file.read(@string_table_size))

      @file.pos = saved_pos
    end

    private def read_record
      record_data = read_char(@record_size)
      record = Records.const_get(record_class_name).new(self, record_data)

      # Cache record if requested.
      @records << record if cache?

      # Ensure we return the record.
      record
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
