module WOW::Capture::Packets::SMSG
  class EncounterEnd < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        int32     :encounter_id
        int32     :difficulty_id
        int32     :group_size

        bit       :succeeded
      end
    end

    def succeeded?
      record.succeeded
    end

    def update_state!
    end
  end
end
