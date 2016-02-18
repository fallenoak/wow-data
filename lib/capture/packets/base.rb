module WOW::Capture::Packets
  class Base
    attr_reader :parser, :header, :record, :references

    def self.structure(&definition)
      @structure = Structure.new(&definition)
    end

    def initialize(parser, header_attributes, data_or_stream)
      @parser = parser

      @header = Header.new(header_attributes)

      if data_or_stream.is_a?(WOW::Capture::Stream)
        @stream = data_or_stream
      else
        @stream = WOW::Capture::Stream.new(@parser, data_or_stream)
      end

      structure = self.class.instance_variable_get(:@structure)
      @record = Records::Root.new(self, structure)

      @references = []

      parse!

      if !@record.empty?
        track_references! rescue nil
        update_state! rescue nil
      end
    end

    private def add_reference!(reference_label, reference_type, entry_type, entry_id)
      @references << WOW::Capture::Utility::Reference.new(header.index, reference_label, reference_type, entry_type, entry_id)
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

    def client_build
      @parser.client_build
    end

    def definitions
      @parser.definitions
    end

    def inspect
      excluded_variables = [:@parser, :@stream]
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

    private def parse!
      @record.parse!(@stream, client_build, definitions)
    end

    private def track_references!
    end

    private def update_state!
    end

    def to_h
      h = {}

      h[:handled] = handled?
      h[:header] = @header.to_h
      h[:record] = handled? ? @record.to_h : nil

      h
    end

    def to_json(opts = {})
      if opts[:pretty]
        JSON.pretty_generate(to_h, indent: (' ' * 4))
      else
        to_h.to_json
      end
    end
  end
end
