module WOW::DB2::Records
  class Base
    attr_reader :fields

    def initialize(parser, structure, data)
      @parser = parser
      @data = StringIO.new(data)
      @structure = structure

      @fields = {}

      read_fields
    end

    private def method_missing(method_name)
      @fields[method_name.to_sym]
    end

    def inspect
      variables = [:@fields]

      prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

      parts = []

      variables.each do |var|
        parts << "#{var}=#{instance_variable_get(var).inspect}"
      end

      str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

      str
    end

    private def read_fields
      @structure.each do |field_definition|
        field_name = field_definition.value
        field_type = field_definition.type
        @fields[field_name] = send("read_#{field_type}")
      end
    end

    private def read_char(length)
      @data.read(length)
    end

    private def read_uint32
      @data.read(4).unpack('V').first
    end

    private def read_int32
      @data.read(4).unpack('i<').first
    end

    private def read_float
      @data.read(4).unpack('e').first
    end

    private def read_string
      offset = read_uint32

      saved_pos = @parser.string_table.pos

      @parser.string_table.pos = offset

      string = ''

      loop do
        character = @parser.string_table.read(1)
        break if character == "\x00" || character.nil?
        string << character
      end

      @parser.string_table.pos = saved_pos

      string
    end
  end
end
