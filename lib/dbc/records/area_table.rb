module WOW::DBC::Records
  class AreaTable < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :map_id],
      [:uint32, :parent_area_id],
      [:uint32, :area_bit],
      [:uint32, :flags1],
      [:uint32, :flags2],
      [:uint32, :sound_provider_pref],
      [:uint32, :sound_provider_pref_underwater],
      [:uint32, :ambience_id],
      [:uint32, :zone_music],
      [:string, :zone_name],
      [:uint32, :intro_sound],
      [:uint32, :exploration_level],
      [:string, :area_name],
      [:uint32, :faction_group_mask],
      [:uint32, :liquid_type1_id],
      [:uint32, :liquid_type2_id],
      [:uint32, :liquid_type3_id],
      [:uint32, :liquid_type4_id],
      [:float,  :ambient_multiplier],
      [:uint32, :mount_flags],
      [:uint32, :uw_intro_music],
      [:uint32, :uw_zone_music],
      [:uint32, :uw_ambience],
      [:uint32, :world_pvp_id],
      [:uint32, :pvp_combat_world_state_id],
      [:uint32, :wild_battle_pet_level_min],
      [:uint32, :wild_battle_pet_level_max],
      [:uint32, :wind_settings_id]
    ]
  end
end
