module WOW::DB2::Records
  class CreatureDisplayInfo < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :creature_model_id],
      [:uint32, :creature_sound_id],
      [:uint32, :creature_display_extra_id],
      [:float,  :creature_model_scale],
      [:float,  :unk_1],
      [:uint32, :creature_model_alpha],
      [:string, :texture_variation_1_name],
      [:string, :texture_variation_2_name],
      [:string, :texture_variation_3_name],
      [:string, :portrait_texture_name],
      [:uint32, :size_class],
      [:int32,  :blood],
      [:uint32, :npc_sound_id],
      [:uint32, :particle_color_id],
      [:uint32, :creature_geoset_data],
      [:uint32, :object_effect_package_id],
      [:uint32, :anim_replacement_set_id],
      [:uint32, :flags],
      [:int32,  :gender],
      [:uint32, :spell_visual_kit_id]
    ]
  end
end
