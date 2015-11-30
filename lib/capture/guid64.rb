module WOW::Capture
  class Guid64
    attr_reader :type, :object_type, :map_id, :entry_id

    def initialize(parser, low)
      @client_build = parser.client_build
      @defs = parser.defs

      @low = low
      @high = nil

      @type = get_high_type

      if @client_build >= 13164
        @entry_id = (@low & 0x000FFFFF00000000) >> 32
      else
        @entry_id = (@low & 0x000FFFFFFF000000) >> 24
      end

      @object_type = get_object_type
      @map_id = nil
    end

    def creature?
      @type == :creature
    end

    def item?
      @type == :item
    end

    # Represent the Guid64 as an integer.
    def to_i
      "#{@low.to_s(16)}".to_i(16)
    end

    # Represent the Guid64 as a hex string.
    def hex
      to_i.to_s(16)
    end

    # Represent the Guid64 as a truncated hex string of a hash.
    def short_id
      Digest::SHA1.hexdigest(hex)[0, 6]
    end

    def pretty_print
      output = ''

      output << "{guid64:0x#{short_id}"
      output << " type:#{@type};"
      output << " entry_id:#{@entry_id}"
      output << "}"

      output
    end

    private def client_build
      @client_build
    end

    private def defs
      @defs
    end

    private def get_legacy_high_type
      if @low == 0
        return defs.legacy_guid_types.high.find_by_value(:none)
      end

      high_value = (@low & 0xF0F0000000000000) >> 52

      case high_value
      when 0x0
        return defs.legacy_guid_types.high.find_by_value(:player)
      when 0x400
        return defs.legacy_guid_types.high.find_by_value(:item)
      else
        return defs.legacy_guid_types.high[high_value]
      end
    end

    private def get_high_type
      legacy_high_type = get_legacy_high_type

      case legacy_high_type
      when :none
        defs.guid_types.high.find_by_value(:null)
      when :player
        defs.guid_types.high.find_by_value(:player)
      when :battleground_1
        defs.guid_types.high.find_by_value(:pvp_queue_group)
      when :instance_save
        defs.guid_types.high.find_by_value(:lfg_list)
      when :group
        defs.guid_types.high.find_by_value(:raid_group)
      when :battleground_2
        defs.guid_types.high.find_by_value(:pvp_queue_group)
      when :mo_transport
        defs.guid_types.high.find_by_value(:transport)
      when :guild
        defs.guid_types.high.find_by_value(:guild)
      when :item
        defs.guid_types.high.find_by_value(:item)
      when :dynamic_object
        defs.guid_types.high.find_by_value(:dynamic_object)
      when :game_object
        defs.guid_types.high.find_by_value(:game_object)
      when :transport
        defs.guid_types.high.find_by_value(:transport)
      when :unit
        defs.guid_types.high.find_by_value(:creature)
      when :pet
        defs.guid_types.high.find_by_value(:pet)
      when :vehicle
        defs.guid_types.high.find_by_value(:vehicle)
      else
        raise StandardError.new("Unexpected high type: #{legacy_high_type}")
      end
    end

    private def get_object_type
      WOW::Capture::OBJECT_TYPES[@object_type_id]
    end

    private def get_object_type_id
      case @type
      when :player
        WOW::Capture::OBJECT_TYPES_INVERSE[:player]
      when :dynamic_object
        WOW::Capture::OBJECT_TYPES_INVERSE[:dynamic_object]
      when :item
        WOW::Capture::OBJECT_TYPES_INVERSE[:item]
      when :game_object, :transport
        WOW::Capture::OBJECT_TYPES_INVERSE[:game_object]
      when :vehicle, :creature, :pet
        WOW::Capture::OBJECT_TYPES_INVERSE[:unit]
      else
        WOW::Capture::OBJECT_TYPES_INVERSE[:creature]
      end
    end
  end
end
