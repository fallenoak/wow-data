module WOW::DBC::Records
  class CreatureFamily < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :min_scale],
      [:uint32, :min_scale_level],
      [:float,  :max_scale],
      [:uint32, :max_scale_level],
      [:uint32, :skill_line_1],
      [:uint32, :skill_line_2],
      [:uint32, :pet_food_mask],
      [:uint32, :pet_talent_type],
      [:uint32, :category_enum_id],
      [:string, :name],
      [:string, :icon_file]
    ]
  end
end
