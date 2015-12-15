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

      table :spell do
        e   0,    :id,                          type: :uint32,  tc_value: 'ID'
        e   1,    :name,                        type: :string,  tc_value: 'Name_lang'
        e   2,    :name_subtext,                type: :string,  tc_value: 'NameSubtext_lang'
        e   3,    :description,                 type: :string,  tc_value: 'Description'
        e   4,    :aura_description,            type: :string,  tc_value: 'AuraDescription_lang'
        e   5,    :rune_cost_id,                type: :uint32,  tc_value: 'RuneCostID'
        e   6,    :spell_missile_id,            type: :uint32,  tc_value: 'SpellMissileID'
        e   7,    :description_variables_id,    type: :uint32,  tc_value: 'DescriptionVariablesID'
        e   8,    :scaling_id,                  type: :uint32,  tc_value: 'ScalingID'
        e   9,    :aura_options_id,             type: :uint32,  tc_value: 'AuraOptionsID'
        e   10,   :aura_restrictions_id,        type: :uint32,  tc_value: 'AuraRestrictionsID'
        e   11,   :casting_requirements_id,     type: :uint32,  tc_value: 'CastingRequirementsID'
        e   12,   :categories_id,               type: :uint32,  tc_value: 'CategoriesID'
        e   13,   :class_options_id,            type: :uint32,  tc_value: 'ClassOptionsID'
        e   14,   :cooldowns_id,                type: :uint32,  tc_value: 'CooldownsID'
        e   15,   :equipped_items_id,           type: :uint32,  tc_value: 'EquippedItemsID'
        e   16,   :interrupts_id,               type: :uint32,  tc_value: 'InterruptsID'
        e   17,   :levels_id,                   type: :uint32,  tc_value: 'LevelsID'
        e   18,   :reagents_id,                 type: :uint32,  tc_value: 'ReagentsID'
        e   19,   :shapeshift_id,               type: :uint32,  tc_value: 'ShapeshiftID'
        e   20,   :target_restrictions_id,      type: :uint32,  tc_value: 'TargetRestrictionsID'
        e   21,   :totems_id,                   type: :uint32,  tc_value: 'TotemsID'
        e   22,   :required_project_id,         type: :uint32,  tc_value: 'RequiredProjectID'
        e   23,   :misc_id,                     type: :uint32,  tc_value: 'MiscID'
      end

      table :spell_icon do
        e   0,    :id,                          type: :uint32,  tc_value: ''
        e   1,    :icon_path,                   type: :string,  tc_value: ''
      end
    end
  end
end
