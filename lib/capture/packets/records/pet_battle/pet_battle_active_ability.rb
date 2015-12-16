module WOW::Capture::Packets::Records
  class PetBattleActiveAbility < WOW::Capture::Packets::Records::Base
    structure do
      int32     :ability_id
      int16     :cooldown_remaining
      int16     :lockdown_remaining
      uint8     :ability_index
      uint8     :pboid
    end
  end
end
