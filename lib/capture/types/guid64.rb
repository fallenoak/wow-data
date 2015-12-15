module WOW::Capture::Types
  class Guid64
    attr_reader :high_type_id, :map_id, :entry_id

    def initialize(parser, low)
      @client_build = parser.client_build
      @defs = parser.defs

      @low = low
      @high = nil

      @high_type_id = (@low & 0xF0F0000000000000) >> 52

      if @client_build >= 13164
        @entry_id = (@low & 0x000FFFFF00000000) >> 32
      else
        @entry_id = (@low & 0x000FFFFFFF000000) >> 24
      end

      @map_id = nil
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

    # Represent the Guid64 as an integer.
    def to_i
      @to_i ||= "#{@low.to_s(16)}".to_i(16)
    end

    # Represent the Guid64 as a hex string.
    def hex
      @hex ||= to_i.to_s(16)
    end

    # Represent the Guid64 as a truncated hex string of a hash.
    def short_id
      @short_id ||= Digest::SHA1.hexdigest(hex)[0, 6]
    end

    # Handle equality checks using the #to_i representation of the Guid64s.
    def ==(other)
      other.is_a?(Guid64) && self.to_i == other.to_i
    end
    alias_method :eql?, :==

    def pretty_print(opts = {})
      output = ''

      if high_type == :null || high_type.nil?
        output << "<guid64:null>"
      else
        output << "<guid64:0x#{short_id}"
        output << " object_type:#{object_type || 'null'};"
        output << " high_type:#{high_type || 'null'};"
        output << " entry_id:#{@entry_id}"
        output << ">"
      end

      output
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

    private def get_legacy_high_type
      if @low == 0
        return @defs.legacy_guid_types.high.find_by_value(:none)
      end

      case @high_type_id
      when 0x0, 0x8
        return @defs.legacy_guid_types.high.find_by_value(:player)
      when 0x408
        return @defs.legacy_guid_types.high.find_by_value(:item)
      else
        if @defs.legacy_guid_types.high[@high_type_id]
          return @defs.legacy_guid_types.high[@high_type_id]
        else
          raise StandardError.new("Unexpected high value: #{high_value}")
        end
      end
    end

    private def get_high_type
      legacy_high_type = get_legacy_high_type

      case legacy_high_type
      when :none
        @defs.guid_types.high.find_by_value(:null)
      when :player
        @defs.guid_types.high.find_by_value(:player)
      when :battleground_1
        @defs.guid_types.high.find_by_value(:pvp_queue_group)
      when :instance_save
        @defs.guid_types.high.find_by_value(:lfg_list)
      when :group
        @defs.guid_types.high.find_by_value(:raid_group)
      when :battleground_2
        @defs.guid_types.high.find_by_value(:pvp_queue_group)
      when :mo_transport
        @defs.guid_types.high.find_by_value(:transport)
      when :guild
        @defs.guid_types.high.find_by_value(:guild)
      when :item
        @defs.guid_types.high.find_by_value(:item)
      when :dynamic_object
        @defs.guid_types.high.find_by_value(:dynamic_object)
      when :game_object
        @defs.guid_types.high.find_by_value(:game_object)
      when :transport
        @defs.guid_types.high.find_by_value(:transport)
      when :unit
        @defs.guid_types.high.find_by_value(:creature)
      when :pet
        @defs.guid_types.high.find_by_value(:pet)
      when :vehicle
        @defs.guid_types.high.find_by_value(:vehicle)
      else
        raise StandardError.new("Unexpected high type: #{legacy_high_type}")
      end
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
  end
end
