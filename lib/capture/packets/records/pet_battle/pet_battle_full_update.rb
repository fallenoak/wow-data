module WOW::Capture::Packets::Records
  class PetBattleFullUpdate < WOW::Capture::Packets::Records::Base
    structure do
      array     :player_updates,          length: 2 do
                  struct source: :pet_battle_player_update
                end

      array     :enviro_updates,          length: 3 do
                  struct source: :pet_battle_enviro_update
                end

      int16     :waiting_for_front_pets_max_secs
      int16     :pvp_max_round_time

      int32     :cur_round
      int32     :npc_creature_id
      int32     :npc_display_id

      uint8     :cur_pet_battle_state
      uint8     :forfeit_penalty

      guid128   :initial_wild_pet_guid,   packed: true

      bit       :is_pvp
      bit       :can_award_xp
    end
  end
end
