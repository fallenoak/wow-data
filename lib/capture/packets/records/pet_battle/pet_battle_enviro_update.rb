module WOW::Capture::Packets::Records
  class PetBattleEnviroUpdate < WOW::Capture::Packets::Records::Base
    structure do
      int32     :active_auras_length
      int32     :active_states_length

      array     :active_auras,            length: proc { active_auras_length } do
                  struct source: :pet_battle_active_aura
                end

      array     :active_states,           length: proc { active_auras_length } do
                  struct source: :pet_battle_active_state
                end
    end
  end
end
