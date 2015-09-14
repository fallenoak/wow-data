module WOW::Definitions
  build 9183 do
    namespace :dbc do
      table :gt_npc_total_hp do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_npc_total_hp_exp1 do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_npc_total_hp_exp2 do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_npc_total_hp_exp3 do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_npc_total_hp_exp4 do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_npc_total_hp_exp5 do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :hp,                          type: :float,   tc_value: ''
      end

      table :gt_oct_base_hp_by_class do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :ratio,                       type: :float,   tc_value: ''
      end

      table :map do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :directory,                   type: :string,  tc_value: ''
        e   2,    :instance_type,               type: :uint32,  tc_value: ''
        e   3,    :flags,                       type: :uint32,  tc_value: ''
        e   4,    :map_type,                    type: :uint32,  tc_value: ''
        e   5,    :unk_1,                       type: :uint32,  tc_value: ''
        e   6,    :map_name,                    type: :string,  tc_value: ''
        e   7,    :area_table_id,               type: :uint32,  tc_value: ''
        e   8,    :map_description_horde,       type: :string,  tc_value: ''
        e   9,    :map_description_alliance,    type: :string,  tc_value: ''
        e   10,   :loading_screen_id,           type: :int32,   tc_value: ''
        e   11,   :minimap_icon_scale,          type: :float,   tc_value: ''
        e   12,   :corpse_map_id,               type: :int32,   tc_value: ''
        e   13,   :corpse_x,                    type: :float,   tc_value: ''
        e   14,   :corpse_y,                    type: :float,   tc_value: ''
        e   15,   :time_of_day_override,        type: :int32,   tc_value: ''
        e   16,   :expansion_id,                type: :uint32,  tc_value: ''
        e   17,   :raid_offset,                 type: :uint32,  tc_value: ''
        e   18,   :max_players,                 type: :uint32,  tc_value: ''
        e   19,   :parent_map_id,               type: :int32,   tc_value: ''
        e   20,   :cosmetic_parent_map_id,      type: :int32,   tc_value: ''
        e   21,   :time_offset,                 type: :uint32,  tc_value: ''
      end

      table :spell_icon do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :icon_path,                   type: :string,  tc_value: ''
      end
    end
  end
end
