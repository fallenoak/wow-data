module WOW::Capture::Packets::Utility
  class Reference
    ENTRY_TYPES = %i(creature item spell quest game_object dynamic_object)

    attr_reader :packet_index, :reference_label, :reference_type, :entry_type, :entry_id

    def initialize(packet_index, reference_label, reference_type, entry_type, entry_id)
      raise 'nil reference_type' if reference_type.nil?
      raise 'unknown entry_type' if !ENTRY_TYPES.include?(entry_type)
      raise 'nil entry_id' if entry_id.nil?

      @reference_type = reference_type
      @entry_type = entry_type
      @entry_id = entry_id
    end
  end
end
