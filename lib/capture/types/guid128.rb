module WOW::Capture::Types
  class Guid128
    attr_reader :realm_id, :server_id, :high_type_id, :sub_type_id, :map_id, :entry_id

    def initialize(parser, low, high)
      @client_build = parser.client_build
      @defs = parser.defs

      @low = low
      @high = high

      @high_type_id = (high >> 58) & 0x3F
      @sub_type_id = (high & 0x3F)

      @realm_id = (high >> 42) & 0x1FFF
      @server_id = (low >> 40) & 0xFFFFFF
      @map_id = (high >> 29) & 0x1FFF
      @entry_id = (high >> 6) & 0x7FFFFF
    end

    def high_type
      @high_type ||= get_high_type
    end
    alias :type :high_type

    def object_type
      @object_type ||= get_object_type
    end

    def creature?
      high_type == :creature
    end

    def item?
      high_type == :item
    end

    # Represent the Guid128 as an integer.
    def to_i
      @to_i ||= "#{@high.to_s(16)}#{@low.to_s(16)}".to_i(16)
    end

    # Represent the Guid128 as a hex string.
    def hex
      @hex ||= to_i.to_s(16)
    end

    # Represent the Guid128 as a truncated hex string of a hash.
    def short_id
      @short_id ||= Digest::SHA1.hexdigest(hex)[0, 6]
    end

    # Handle equality checks using the #to_i representation of the Guid128s.
    def ==(other)
      other.is_a?(Guid128) && self.to_i == other.to_i
    end
    alias_method :eql?, :==

    def pretty_print(opts = {})
      output = ''

      if high_type == :null || high_type.nil?
        output << "<guid128:null>"
      else
        output << "<guid128:"
        output << (opts[:full_id] ? "0x#{hex}" : "0x#{short_id}")
        output << " object_type:#{object_type || 'null'};"
        output << " high_type:#{high_type || 'null'};"
        output << " realm_id:#{@realm_id};"
        output << " server_id:#{@server_id};"
        output << " map_id:#{@map_id};"
        output << " entry_id:#{@entry_id}"
        output << ">"
      end

      output
    end

    def to_h
      if high_type == :null || high_type.nil?
        {
          _t: 'guid128',
          guid: nil
        }
      else
        {
          _t: 'guid128',
          guid: "0x#{hex.upcase}",
          object_type: object_type,
          high_type: high_type,
          realm_id: realm_id,
          server_id: server_id,
          map_id: map_id,
          entry_id: entry_id
        }
      end
    end

    def to_json
      to_h.to_json
    end

    def inspect
      excluded_variables = [:@client_build, :@defs, :@to_i, :@hex, :@short_id]
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

    private def get_high_type
      @defs.guid_types.high[@high_type_id]
    end

    private def get_object_type
      case high_type
      when :player
        @defs.object_types.find_by_value(:player)
      when :dynamic_object
        @defs.object_types.find_by_value(:dynamic_object)
      when :item
        @defs.object_types.find_by_value(:item)
      when :game_object, :transport
        @defs.object_types.find_by_value(:game_object)
      when :vehicle, :creature, :pet
        @defs.object_types.find_by_value(:unit)
      when nil
        nil
      else
        @defs.object_types.find_by_value(:creature)
      end
    end

    def to_h
      h = {}

      h[:hex] = hex
      h[:int] = to_i

      h[:high_type] = high_type

      if high_type != :null
        h[:object_type] = object_type
        h[:entry_id] = entry_id
        h[:map_id] = map_id
      end

      h
    end
  end
end
