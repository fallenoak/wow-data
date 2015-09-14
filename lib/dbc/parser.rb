module WOW::DBC
  class Parser
    attr_reader :record_count, :field_count, :record_size, :string_table_size, :string_table,
      :records

    def initialize(path, opts = {})
      @path = path
      @file = File.open(path, 'rb')

      @filename = path.split('/').last

      @header_size = 20
      @magic = nil
      @record_count = nil
      @field_count = nil
      @record_size = nil
      @string_table_start = nil
      @string_table_size = nil
      @string_table = nil

      @build = nil

      @structure = nil

      @records = []

      read_header
      read_string_table
      load_build_number
      load_structure

      # Default to non-lazy w/ caching.
      @lazy = opts[:lazy] == true
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

    def closed?
      @file.closed?
    end

    def eof?
      closed? || @file.pos >= @header_size + (@record_size * @record_count)
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
      @string_table_start = @header_size + (@record_size * @record_count)
    end

    private def read_record
      record_data = read_char(@record_size)
      record = Records.const_get(record_class_name).new(self, @structure, record_data)

      # Cache record if requested.
      @records << record if cache?

      # Ensure we return the record.
      record
    end

    private def read_string_table
      saved_pos = @file.pos

      @file.pos = @string_table_start
      @string_table = StringIO.new(@file.read(@string_table_size))

      @file.pos = saved_pos
    end

    private def read_char(length)
      @file.read(length)
    end

    private def read_uint32
      @file.read(4).unpack('L<').first
    end

    private def read_int32
      @file.read(4).unpack('l<').first
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

    private def record_table_name
      underscore(record_class_name)
    end

    private def underscore(camel_cased_word)
      camel_cased_word.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    private def load_build_number
      digest = Digest::SHA256.file(@path).hexdigest
      filename = @path.split('/').last.downcase.to_sym

      matched_file = VERSIONS.keys.select { |v| v.to_s.downcase.to_sym == filename }.first
      raise 'Unknown DBC file!' if matched_file.nil?

      versions = VERSIONS[matched_file]
      build_number = versions[digest.to_sym]
      raise 'Unknown build!' if build_number.nil?

      @build = build_number
    end

    private def load_structure
      @structure = WOW::Definitions.for_build(@build, merged: true).dbc.send(record_table_name)
    end
  end
end
