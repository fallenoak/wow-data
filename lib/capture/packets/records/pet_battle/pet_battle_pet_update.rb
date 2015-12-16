module WOW::Capture::Packets::Records
  class PetBattlePetUpdate < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :pet_guid,                  packed: true

      int32     :species_id
      int32     :display_id
      int32     :collar_id

      int16     :level
      int16     :xp

      int32     :current_health
      int32     :max_health
      int32     :power
      int32     :speed

      int32     :npc_team_member_id

      int16     :breed_quality
      int16     :status_flags

      uint8     :slot

      int32     :active_abilities_length
      int32     :active_auras_length
      int32     :active_states_length

      array     :active_abilities,          length: proc { active_abilities_length } do
                  struct source: :pet_battle_active_ability
                end

      array     :active_auras,              length: proc { active_auras_length } do
                  struct source: :pet_battle_active_aura
                end

      array     :active_states,             length: proc { active_states_length } do
                  struct source: :pet_battle_active_state
                end

      reset_bit_reader

      bits      :custom_name_length,        length: 7
      string    :custom_name,               length: proc { custom_name_length }
    end
  end
end
