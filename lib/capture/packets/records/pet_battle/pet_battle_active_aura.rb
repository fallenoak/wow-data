module WOW::Capture::Packets::Records
  class PetBattleActiveAura < WOW::Capture::Packets::Records::Base
    structure do
      int32     :ability_id
      int32     :instance_id
      int32     :rounds_remaining
      int32     :current_round
      uint8     :caster_pboid
    end
  end
end
