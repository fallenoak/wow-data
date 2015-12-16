module WOW::Capture::Packets::Records
  class PetBattleActiveState < WOW::Capture::Packets::Records::Base
    structure do
      int32     :state_id
      int32     :state_value
    end
  end
end
