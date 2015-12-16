module WOW::Capture::Packets::Records
  class MovementSceneObj < WOW::Capture::Packets::Records::Base
    structure do
      reset_bit_reader

      bit       :has_scene_local_script_data
      bit       :has_pet_battle_full_update

      struct    :scene_local_script_data,       if: proc { has_scene_local_script_data } do
                  reset_bit_reader

                  bits    :data_length, length: 7
                  string  :data,        length: 7
                end

      struct    :pet_battle_full_update,        if: proc { has_pet_battle_full_update },
                                                source: :pet_battle_full_update
    end
  end
end
