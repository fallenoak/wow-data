module WOW::Definitions
  build 19027 do
    namespace :dbc do
      table :area_table do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :map_id,                      type: :uint32,  tc_value: ''
        e   2,    :parent_area_id,              type: :uint32,  tc_value: ''
        e   3,    :area_bit,                    type: :uint32,  tc_value: ''
        e   4,    :flags_1,                     type: :uint32,  tc_value: ''
        e   5,    :flags_2,                     type: :uint32,  tc_value: ''
        e   6,    :sound_provider_pref,         type: :uint32,  tc_value: ''
        e   7,    :sound_provider_pref_underwater, type: :uint32, tc_value: ''
        e   8,    :ambience_id,                 type: :uint32,  tc_value: ''
        e   9,    :zone_music,                  type: :uint32,  tc_value: ''
        e   10,   :zone_name,                   type: :string,  tc_value: ''
        e   11,   :intro_sound,                 type: :uint32,  tc_value: ''
        e   12,   :exploration_level,           type: :uint32,  tc_value: ''
        e   13,   :area_name,                   type: :string,  tc_value: ''
        e   14,   :faction_group_mask,          type: :uint32,  tc_value: ''
        e   15,   :liquid_type_1_id,            type: :uint32,  tc_value: ''
        e   16,   :liquid_type_2_id,            type: :uint32,  tc_value: ''
        e   17,   :liquid_type_3_id,            type: :uint32,  tc_value: ''
        e   18,   :liquid_type_4_id,            type: :uint32,  tc_value: ''
        e   19,   :ambient_multiplier,          type: :float,   tc_value: ''
        e   20,   :mount_flags,                 type: :uint32,  tc_value: ''
        e   21,   :uw_intro_music,              type: :uint32,  tc_value: ''
        e   22,   :uw_zone_music,               type: :uint32,  tc_value: ''
        e   23,   :uw_ambience,                 type: :uint32,  tc_value: ''
        e   24,   :world_pvp_id,                type: :uint32,  tc_value: ''
        e   25,   :pvp_combat_world_state_id,   type: :uint32,  tc_value: ''
        e   26,   :wild_battle_pet_level_min,   type: :uint32,  tc_value: ''
        e   27,   :wild_battle_pet_level_max,   type: :uint32,  tc_value: ''
        e   28,   :wind_settings_id,            type: :uint32,  tc_value: ''
      end
    end
  end
end
