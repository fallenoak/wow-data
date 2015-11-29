module WOW::Capture::Packets::SMSG
  class EncounterEnd < WOW::Capture::Packets::Base
    attr_reader :encounter_id, :difficulty_id, :group_size, :succeeded

    def parse!
      @encounter_id = read_int32
      @difficulty_id = read_int32
      @group_size = read_int32
      @succeeded = read_bit
    end

    def succeeded?
      @succeeded
    end

    def update_state!
    end
  end
end
