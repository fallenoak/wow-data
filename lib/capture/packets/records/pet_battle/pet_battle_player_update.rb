module WOW::Capture::Packets::Records
  class PetBattlePlayerUpdate < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :character_guid,      packed: true

      int32     :trap_ability_id
      int32     :trap_status

      int16     :round_time_secs
      int8      :front_pet
      uint8     :input_flags

      reset_bit_reader

      bits      :pet_updates_length,  length: 2

      array     :pet_updates,         length: proc { pet_updates_length } do
                  struct source: :pet_battle_pet_update
                end
    end
  end
end
