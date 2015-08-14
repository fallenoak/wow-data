module WOW::DBC::Records
  class CreatureFamily < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :min_scale],
      [:uint32, :min_scale_level],
      [:float,  :max_scale],
      [:uint32, :max_scale_level],
      [:uint32, :skill_line_1_id],
      [:uint32, :skill_line_2_id],
      [:uint32, :pet_food_mask],
      [:int32,  :pet_talent_type],
      [:uint32, :category_enum_id],
      [:string, :name],
      [:string, :icon_path]
    ]
  end
end
