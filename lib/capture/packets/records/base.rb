module WOW::Capture::Packets::Records
  class Base
    def self.structure(&definition)
      @structure = WOW::Capture::Packets::Structure.new(&definition)
    end

    def self.inherited(subclass)
      record_name = subclass.to_s.
        split('::').
        last.
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase.
        to_sym

      WOW::Capture::Packets::Records.add(record_name, subclass)
    end

    def initialize(root = nil)
      @attributes = {}
      @private = []
      @structure = self.class.instance_variable_get(:@structure)
      @root = root || self
    end

    def structure
      @structure
    end

    def parse!(stream, client_build, definitions)
      return if structure.nil?
      structure.parse!(self, stream, client_build, definitions)
    end

    def merge!(incoming_record)
      @attributes.merge!(incoming_record.instance_variable_get(:@attributes))
    end

    def []=(key, value)
      @attributes[key] = value
    end

    def set_attribute(key, value, make_private = false)
      @attributes[key] = value

      @private << key if !@private.include?(key) && make_private

      value
    end

    def [](key)
      @attributes[key]
    end

    def has_key?(key)
      @attributes.has_key?(key)
    end

    def empty?
      @attributes.empty?
    end

    def method_missing(key)
      @attributes[key]
    end

    def root
      @root || self
    end

    def inspect
      excluded_variables = [:@structure, :@root, :@packet]
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

    def to_h(local_attributes = nil)
      h = {}

      local_attributes = @attributes if local_attributes.nil?

      local_attributes.each_pair do |key, value|
        next if @private.include?(key)

        case value
        when WOW::Capture::Types::ObjectUpdate
          if value.value.nil?
            h[key] = value.to_s
          else
            case value.value
            when Integer, Float, TrueClass, FalseClass, NilClass
              h[key] = value.value
            when String
              h[key] = value.value.dup.force_encoding('ISO-8859-1').encode('UTF-8')
            else
              if value.value.respond_to?(:to_h)
                h[key] = value.value.to_h
              else
                h[key] = value.value.to_s
              end
            end
          end
        when Integer, Float, TrueClass, FalseClass, NilClass
          h[key] = value
        when String
          h[key] = value.dup.force_encoding('ISO-8859-1').encode('UTF-8')
        when Hash
          h[key] = to_h(value.dup)
        when Array
          values = []

          value.map do |array_value|
            case array_value
            when Integer, Float, TrueClass, FalseClass, NilClass
              values << array_value
            when String
              values << array_value.dup.force_encoding('ISO-8859-1').encode('UTF-8')
            when Hash
              values << to_h(array_value.dup)
            when Array
              values << array_value.dup
            else
              if array_value.respond_to?(:to_h)
                values << array_value.to_h
              else
                values << array_value.to_s
              end
            end
          end

          h[key] = values
        else
          if value.respond_to?(:to_h)
            h[key] = value.to_h
          else
            h[key] = value.to_s
          end
        end
      end

      h
    end

    def to_json(opts = {})
      to_h.to_json
    end

    def pretty_print(opts = {})
      return '' if @attributes.empty?
      JSON.pretty_generate(to_h, indent: (' ' * 4))
    end
  end
end
