module WOW::Definitions
  build 9183 do
    namespace :dbc do
      table :file_data do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :file_name,                   type: :string,  tc_value: ''
        e   2,    :file_path,                   type: :string,  tc_value: ''
      end

      table :item_display_info do
        e   0,    :id,                          type: :uint32
        e   1,    :left_model,                  type: :string
        e   2,    :right_model,                 type: :string
        e   3,    :left_model_texture,          type: :string
        e   4,    :right_model_texture,         type: :string
        e   5,    :icon_1_name,                 type: :string
        e   6,    :icon_2_name,                 type: :string
        e   7,    :geoset_1_group,              type: :uint32
        e   8,    :geoset_2_group,              type: :uint32
        e   9,    :geoset_3_group,              type: :uint32
        e   10,   :flags,                       type: :uint32
        e   11,   :spell_visual_id,             type: :uint32
      end
    end
  end
end
