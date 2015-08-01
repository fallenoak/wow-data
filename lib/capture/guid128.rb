module WOW::Capture
  class Guid128
    attr_reader :realm_id, :server_id, :high_type_id, :sub_type_id, :object_type_id,
      :type, :object_type, :map_id, :entry_id

    def initialize(low, high)
      @low = low
      @high = high

      @high_type_id = (high >> 58) & 0x3F
      @sub_type_id = (high & 0x3F)

      @type = get_type

      @object_type_id = get_object_type_id
      @object_type = get_object_type

      @realm_id = (high >> 42) & 0x1FFF
      @server_id = (low >> 40) & 0xFFFFFF
      @map_id = (high >> 29) & 0x1FFF
      @entry_id = (high >> 6) & 0x7FFFFF
    end

    # Represent the Guid128 as an integer.
    def to_i
      "#{@high.to_s(16)}#{@low.to_s(16)}".to_i(16)
    end

    # Represent the Guid128 as a hex string.
    def hex
      to_i.to_s(16)
    end

    # Represent the Guid128 as a truncated hex string of a hash.
    def short_id
      Digest::SHA1.hexdigest(hex)[0, 6]
    end

    def pretty_print
      output = ''

      output << "{guid128:0x#{short_id}"
      output << " type:#{@type};"
      output << " realm_id:#{@realm_id};"
      output << " server_id:#{@server_id};"
      output << " map_id:#{@map_id};"
      output << " entry_id:#{@entry_id}"
      output << "}"

      output
    end

    private def get_type
      WOW::Capture::GuidTypes::HIGH_TYPES[@high_type_id]
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
