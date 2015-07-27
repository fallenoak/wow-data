module WOW::Capture
  class Guid128
    attr_reader :realm_id, :server_id, :object_type, :map_id, :entry_id

    def initialize(low, high)
      @high_type_id = (high >> 58) & 0x3F
      @sub_type_id = (high & 0x3F)
      @object_type = get_object_type

      @realm_id = (high >> 42) & 0x1FFF
      @server_id = (low >> 40) & 0xFFFFFF
      @map_id = (high >> 29) & 0x1FFF
      @entry_id = (high >> 6) & 0x7FFFFF
    end

    private def get_object_type
      WOW::Capture::GuidTypes::HighTypes[@high_type_id]
    end
  end
end
