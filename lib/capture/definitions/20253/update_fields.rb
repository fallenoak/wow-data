module WOW::Capture::Definitions
  build 20253 do
    namespace :update_fields do
      table :object_fields do
        e   0x000,  :object_guid,                             type: :guid128,   blocks: 4
        e   0x004,  :object_data,                             type: :uint32,    blocks: 1
        e   0x008,  :object_type,                             type: :uint32,    blocks: 1
        e   0x009,  :object_entry,                            type: :uint32,    blocks: 1
        e   0x00A,  :object_dynamic_flags,                    type: :uint32,    blocks: 1
        e   0x00B,  :object_scale_x,                          type: :float,     blocks: 1

        x   0x00B
      end

      table :item_fields do
        i   :object_fields

        e   0x000,  :item_owner_guid,                         type: :guid128,   blocks: 4
        e   0x004,  :item_contained,                          type: :uint32,    blocks: 1
        e   0x008,  :item_creator,                            type: :uint32,    blocks: 1
        e   0x00C,  :item_gift_creator,                       type: :uint32,    blocks: 1
        e   0x010,  :item_stack_count,                        type: :uint32,    blocks: 1
        e   0x011,  :item_duration,                           type: :uint32,    blocks: 1
        e   0x012,  :item_spell_charges,                      type: :uint32,    blocks: 1
        e   0x017,  :item_flags,                              type: :uint32,    blocks: 1
        e   0x018,  :item_enchantment,                        type: :uint32,    blocks: 1
        e   0x03F,  :item_property_seed,                      type: :uint32,    blocks: 1
        e   0x040,  :item_random_properties_id,               type: :uint32,    blocks: 1
        e   0x041,  :item_durability,                         type: :uint32,    blocks: 1
        e   0x042,  :item_max_durability,                     type: :uint32,    blocks: 1
        e   0x043,  :item_create_played_time,                 type: :uint32,    blocks: 1
        e   0x044,  :item_modifiers_mask,                     type: :uint32,    blocks: 1
        e   0x045,  :item_context,                            type: :uint32,    blocks: 1

        x   0x045
      end

      table :container_fields do
        i   :object_fields

        e   0x000,  :container_slot,                          type: :uint32,    blocks: 1
        e   0x090,  :container_num_slots,                     type: :uint32,    blocks: 1

        x   0x090
      end

      table :unit_fields do
        i   :object_fields

        e   0x000,  :unit_charm,                              type: :uint32,    blocks: 1
        e   0x004,  :unit_summon,                             type: :uint32,    blocks: 1
        e   0x008,  :unit_critter,                            type: :uint32,    blocks: 1
        e   0x00C,  :unit_charmed_by,                         type: :uint32,    blocks: 1
        e   0x010,  :unit_summoned_by,                        type: :uint32,    blocks: 1
        e   0x014,  :unit_created_by,                         type: :uint32,    blocks: 1
        e   0x018,  :unit_demon_creator,                      type: :uint32,    blocks: 1
        e   0x01C,  :unit_target,                             type: :uint32,    blocks: 1
        e   0x020,  :unit_battle_pet_companion_guid,          type: :uint32,    blocks: 1
        e   0x024,  :unit_battle_pet_db_id,                   type: :uint32,    blocks: 1
        e   0x026,  :unit_channel_object,                     type: :uint32,    blocks: 1
        e   0x02A,  :unit_channel_spell,                      type: :uint32,    blocks: 1
        e   0x02B,  :unit_channel_spell_x_spell_visual,       type: :uint32,    blocks: 1
        e   0x02C,  :unit_summoned_by_home_realm,             type: :uint32,    blocks: 1
        e   0x02D,  :unit_bytes_0,                            type: :uint32,    blocks: 1
        e   0x02E,  :unit_display_power,                      type: :uint32,    blocks: 1
        e   0x02F,  :unit_override_display_power_id,          type: :uint32,    blocks: 1
        e   0x030,  :unit_health,                             type: :uint32,    blocks: 1
        e   0x031,  :unit_power,                              type: :uint32,    blocks: 1
        e   0x037,  :unit_max_health,                         type: :uint32,    blocks: 1
        e   0x038,  :unit_max_power,                          type: :uint32,    blocks: 1
        e   0x03E,  :unit_power_regen_flat_modifier,          type: :uint32,    blocks: 1
        e   0x044,  :unit_power_regen_interrupted_flat_modifier, type: :uint32, blocks: 1
        e   0x04A,  :unit_level,                              type: :uint32,    blocks: 1
        e   0x04B,  :unit_effective_level,                    type: :uint32,    blocks: 1
        e   0x04C,  :unit_faction_template,                   type: :uint32,    blocks: 1
        e   0x04D,  :unit_virtual_item_slot_id,               type: :uint32,    blocks: 1
        e   0x053,  :unit_flags,                              type: :uint32,    blocks: 1
        e   0x056,  :unit_aura_state,                         type: :uint32,    blocks: 1
        e   0x057,  :unit_base_attack_time,                   type: :uint32,    blocks: 1
        e   0x059,  :unit_ranged_attack_time,                 type: :uint32,    blocks: 1
        e   0x05A,  :unit_bounding_radius,                    type: :float,     blocks: 1
        e   0x05B,  :unit_combat_reach,                       type: :float,     blocks: 1
        e   0x05C,  :unit_display_id,                         type: :uint32,    blocks: 1
        e   0x05D,  :unit_native_display_id,                  type: :uint32,    blocks: 1
        e   0x05E,  :unit_mount_display_id,                   type: :uint32,    blocks: 1
        e   0x05F,  :unit_min_damage,                         type: :uint32,    blocks: 1
        e   0x060,  :unit_max_damage,                         type: :uint32,    blocks: 1
        e   0x061,  :unit_min_offhand_damage,                 type: :uint32,    blocks: 1
        e   0x062,  :unit_max_offhand_damage,                 type: :uint32,    blocks: 1
        e   0x063,  :unit_bytes_1,                            type: :uint32,    blocks: 1
        e   0x064,  :unit_pet_number,                         type: :uint32,    blocks: 1
        e   0x065,  :unit_pet_name_timestamp,                 type: :uint32,    blocks: 1
        e   0x066,  :unit_pet_experience,                     type: :uint32,    blocks: 1
        e   0x067,  :unit_pet_next_level_exp,                 type: :uint32,    blocks: 1
        e   0x068,  :unit_mod_cast_speed,                     type: :float,     blocks: 1
        e   0x069,  :unit_mod_cast_haste,                     type: :float,     blocks: 1
        e   0x06A,  :unit_mod_haste,                          type: :float,     blocks: 1
        e   0x06B,  :unit_mod_ranged_haste,                   type: :float,     blocks: 1
        e   0x06C,  :unit_mod_haste_regen,                    type: :float,     blocks: 1
        e   0x06D,  :unit_created_by_spell,                   type: :uint32,    blocks: 1
        e   0x06E,  :unit_npc_flags,                          type: :uint32,    blocks: 1
        e   0x070,  :unit_npc_emotestate,                     type: :uint32,    blocks: 1
        e   0x071,  :unit_stat,                               type: :uint32,    blocks: 1
        e   0x076,  :unit_pos_stat,                           type: :uint32,    blocks: 1
        e   0x07B,  :unit_neg_stat,                           type: :uint32,    blocks: 1
        e   0x080,  :unit_resistances,                        type: :uint32,    blocks: 1
        e   0x087,  :unit_resistance_buff_mods_positive,      type: :uint32,    blocks: 1
        e   0x08E,  :unit_resistance_buff_mods_negative,      type: :uint32,    blocks: 1
        e   0x095,  :unit_mod_bonus_armor,                    type: :uint32,    blocks: 1
        e   0x096,  :unit_base_mana,                          type: :uint32,    blocks: 1
        e   0x097,  :unit_base_health,                        type: :uint32,    blocks: 1
        e   0x098,  :unit_bytes_3,                            type: :uint32,    blocks: 1
        e   0x099,  :unit_attack_power,                       type: :uint32,    blocks: 1
        e   0x09A,  :unit_attack_power_mod_pos,               type: :uint32,    blocks: 1
        e   0x09B,  :unit_attack_power_mod_neg,               type: :uint32,    blocks: 1
        e   0x09C,  :unit_attack_power_multiplier,            type: :uint32,    blocks: 1
        e   0x09D,  :unit_ranged_attack_power,                type: :uint32,    blocks: 1
        e   0x09E,  :unit_ranged_attack_power_mod_pos,        type: :uint32,    blocks: 1
        e   0x09F,  :unit_ranged_attack_power_mod_neg,        type: :uint32,    blocks: 1
        e   0x0A0,  :unit_ranged_attack_power_multiplier,     type: :uint32,    blocks: 1
        e   0x0A1,  :unit_min_ranged_damage,                  type: :uint32,    blocks: 1
        e   0x0A2,  :unit_max_ranged_damage,                  type: :uint32,    blocks: 1
        e   0x0A3,  :unit_power_cost_modifier,                type: :uint32,    blocks: 1
        e   0x0AA,  :unit_power_cost_multiplier,              type: :uint32,    blocks: 1
        e   0x0B1,  :unit_max_health_modifier,                type: :uint32,    blocks: 1
        e   0x0B2,  :unit_hover_height,                       type: :uint32,    blocks: 1
        e   0x0B3,  :unit_min_item_level_cutoff,              type: :uint32,    blocks: 1
        e   0x0B4,  :unit_min_item_level,                     type: :uint32,    blocks: 1
        e   0x0B5,  :unit_max_item_level,                     type: :uint32,    blocks: 1
        e   0x0B6,  :unit_wild_battlepet_level,               type: :uint32,    blocks: 1
        e   0x0B7,  :unit_battlepet_companion_name_timestamp, type: :uint32,    blocks: 1
        e   0x0B8,  :unit_interact_spell_id,                  type: :uint32,    blocks: 1
        e   0x0B9,  :unit_state_spell_visual_id,              type: :uint32,    blocks: 1
        e   0x0BA,  :unit_state_anim_id,                      type: :uint32,    blocks: 1
        e   0x0BB,  :unit_state_anim_kit_id,                  type: :uint32,    blocks: 1
        e   0x0BC,  :unit_state_world_effect_id,              type: :uint32,    blocks: 1
        e   0x0C0,  :unit_scale_duration,                     type: :uint32,    blocks: 1
        e   0x0C1,  :unit_looks_like_mount_id,                type: :uint32,    blocks: 1
        e   0x0C2,  :unit_looks_like_creature_id,             type: :uint32,    blocks: 1
        e   0x0C3,  :unit_look_at_controller_id,              type: :uint32,    blocks: 1
        e   0x0C4,  :unit_look_at_controller_target,          type: :uint32,    blocks: 1

        x   0x0C7
      end

      table :player_fields do
        i   :object_fields
        i   :unit_fields

        e   0x000,  :player_duel_arbiter,                     type: :uint32,    blocks: 1
        e   0x004,  :player_wow_account,                      type: :uint32,    blocks: 1
        e   0x008,  :player_loot_target_guid,                 type: :uint32,    blocks: 1
        e   0x00C,  :player_flags,                            type: :uint32,    blocks: 1
        e   0x00D,  :player_flags_ex,                         type: :uint32,    blocks: 1
        e   0x00E,  :player_guild_rank,                       type: :uint32,    blocks: 1
        e   0x00F,  :player_guild_delete_date,                type: :uint32,    blocks: 1
        e   0x010,  :player_guild_level,                      type: :uint32,    blocks: 1
        e   0x011,  :player_bytes,                            type: :uint32,    blocks: 1
        e   0x014,  :player_duel_team,                        type: :uint32,    blocks: 1
        e   0x015,  :player_guild_timestamp,                  type: :uint32,    blocks: 1
        e   0x016,  :player_quest_log,                        type: :uint32,    blocks: 1
        e   0x304,  :player_visible_item,                     type: :uint32,    blocks: 1
        e   0x32A,  :player_chosen_title,                     type: :uint32,    blocks: 1
        e   0x32B,  :player_fake_inebriation,                 type: :uint32,    blocks: 1
        e   0x32C,  :player_virtual_player_realm,             type: :uint32,    blocks: 1
        e   0x32D,  :player_current_spec_id,                  type: :uint32,    blocks: 1
        e   0x32E,  :player_taxi_mount_anim_kit_id,           type: :uint32,    blocks: 1
        e   0x32F,  :player_avg_item_level,                   type: :uint32,    blocks: 1
        e   0x333,  :player_current_battle_pet_breed_quality, type: :uint32,    blocks: 1
        e   0x334,  :player_inv_slot_head,                    type: :uint32,    blocks: 1
        e   0x614,  :player_farsight,                         type: :uint32,    blocks: 1
        e   0x618,  :player_known_titles,                     type: :uint32,    blocks: 1
        e   0x622,  :player_coinage,                          type: :uint32,    blocks: 1
        e   0x624,  :player_xp,                               type: :uint32,    blocks: 1
        e   0x625,  :player_next_level_xp,                    type: :uint32,    blocks: 1
        e   0x626,  :player_skill_line_id,                    type: :uint32,    blocks: 1
        e   0x7E6,  :player_character_points,                 type: :uint32,    blocks: 1
        e   0x7E7,  :player_max_talent_tiers,                 type: :uint32,    blocks: 1
        e   0x7E8,  :player_track_creatures,                  type: :uint32,    blocks: 1
        e   0x7E9,  :player_track_resources,                  type: :uint32,    blocks: 1
        e   0x7EA,  :player_expertise,                        type: :uint32,    blocks: 1
        e   0x7EB,  :player_offhand_expertise,                type: :uint32,    blocks: 1
        e   0x7EC,  :player_ranged_expertise,                 type: :uint32,    blocks: 1
        e   0x7ED,  :player_combat_rating_expertise,          type: :uint32,    blocks: 1
        e   0x7EE,  :player_block_percentage,                 type: :uint32,    blocks: 1
        e   0x7EF,  :player_dodge_percentage,                 type: :uint32,    blocks: 1
        e   0x7F0,  :player_parry_percentage,                 type: :uint32,    blocks: 1
        e   0x7F1,  :player_crit_percentage,                  type: :uint32,    blocks: 1
        e   0x7F2,  :player_ranged_crit_percentage,           type: :uint32,    blocks: 1
        e   0x7F3,  :player_offhand_crit_percentage,          type: :uint32,    blocks: 1
        e   0x7F4,  :player_spell_crit_percentage,            type: :uint32,    blocks: 1
        e   0x7FB,  :player_shield_block,                     type: :uint32,    blocks: 1
        e   0x7FC,  :player_shield_block_crit_percentage,     type: :uint32,    blocks: 1
        e   0x7FD,  :player_mastery,                          type: :uint32,    blocks: 1
        e   0x7FE,  :player_amplify,                          type: :uint32,    blocks: 1
        e   0x7FF,  :player_multistrike,                      type: :uint32,    blocks: 1
        e   0x800,  :player_multistrike_effect,               type: :uint32,    blocks: 1
        e   0x801,  :player_readiness,                        type: :uint32,    blocks: 1
        e   0x802,  :player_speed,                            type: :uint32,    blocks: 1
        e   0x803,  :player_lifesteal,                        type: :uint32,    blocks: 1
        e   0x804,  :player_avoidance,                        type: :uint32,    blocks: 1
        e   0x805,  :player_sturdiness,                       type: :uint32,    blocks: 1
        e   0x806,  :player_cleave,                           type: :uint32,    blocks: 1
        e   0x807,  :player_versatility,                      type: :uint32,    blocks: 1
        e   0x808,  :player_versatility_bonus,                type: :uint32,    blocks: 1
        e   0x809,  :player_pvp_power_damage,                 type: :uint32,    blocks: 1
        e   0x80A,  :player_pvp_power_healing,                type: :uint32,    blocks: 1
        e   0x80B,  :player_explored_zones,                   type: :uint32,    blocks: 1
        e   0x90B,  :player_rest_state_experience,            type: :uint32,    blocks: 1
        e   0x90C,  :player_mod_damage_done_pos,              type: :uint32,    blocks: 1
        e   0x913,  :player_mod_damage_done_neg,              type: :uint32,    blocks: 1
        e   0x91A,  :player_mod_damage_done_pct,              type: :uint32,    blocks: 1
        e   0x921,  :player_mod_healing_done_pos,             type: :uint32,    blocks: 1
        e   0x922,  :player_mod_healing_pct,                  type: :uint32,    blocks: 1
        e   0x923,  :player_mod_healing_done_pct,             type: :uint32,    blocks: 1
        e   0x924,  :player_mod_periodic_healing_done_pct,    type: :uint32,    blocks: 1
        e   0x925,  :player_weapon_dmg_multipliers,           type: :uint32,    blocks: 1
        e   0x928,  :player_weapon_atk_speed_multipliers,     type: :uint32,    blocks: 1
        e   0x92B,  :player_mod_spell_power_pct,              type: :uint32,    blocks: 1
        e   0x92C,  :player_mod_resilience_percent,           type: :uint32,    blocks: 1
        e   0x92D,  :player_override_spell_power_by_ap_pct,   type: :uint32,    blocks: 1
        e   0x92E,  :player_override_ap_by_spell_power_pct,   type: :uint32,    blocks: 1
        e   0x92F,  :player_mod_target_resistance,            type: :uint32,    blocks: 1
        e   0x930,  :player_mod_target_physical_resistance,   type: :uint32,    blocks: 1
        e   0x931,  :player_local_flags,                      type: :uint32,    blocks: 1
        e   0x932,  :player_bytes,                            type: :uint32,    blocks: 1
        e   0x933,  :player_self_res_spell,                   type: :uint32,    blocks: 1
        e   0x934,  :player_pvp_medals,                       type: :uint32,    blocks: 1
        e   0x935,  :player_buyback_price,                    type: :uint32,    blocks: 1
        e   0x941,  :player_buyback_timestamp,                type: :uint32,    blocks: 1
        e   0x94D,  :player_kills,                            type: :uint32,    blocks: 1
        e   0x94E,  :player_lifetime_honorable_kills,         type: :uint32,    blocks: 1
        e   0x94F,  :player_watched_faction_index,            type: :uint32,    blocks: 1
        e   0x950,  :player_combat_rating,                    type: :uint32,    blocks: 1
        e   0x970,  :player_arena_team_info,                  type: :uint32,    blocks: 1
        e   0x994,  :player_max_level,                        type: :uint32,    blocks: 1
        e   0x995,  :player_rune_regen,                       type: :uint32,    blocks: 1
        e   0x999,  :player_no_reagent_cost,                  type: :uint32,    blocks: 1
        e   0x99D,  :player_glyph_slots,                      type: :uint32,    blocks: 1
        e   0x9A3,  :player_glyphs,                           type: :uint32,    blocks: 1
        e   0x9A9,  :player_glyphs_enabled,                   type: :uint32,    blocks: 1
        e   0x9AA,  :player_pet_spell_power,                  type: :uint32,    blocks: 1
        e   0x9AB,  :player_researching,                      type: :uint32,    blocks: 1
        e   0x9B5,  :player_profession_skill_line,            type: :uint32,    blocks: 1
        e   0x9B7,  :player_ui_hit_modifier,                  type: :uint32,    blocks: 1
        e   0x9B8,  :player_ui_spell_hit_modifier,            type: :uint32,    blocks: 1
        e   0x9B9,  :player_home_realm_time_offset,           type: :uint32,    blocks: 1
        e   0x9BA,  :player_mod_pet_haste,                    type: :uint32,    blocks: 1
        e   0x9BB,  :player_summoned_battle_pet_id,           type: :uint32,    blocks: 1
        e   0x9BF,  :player_bytes_2,                          type: :uint32,    blocks: 1
        e   0x9C0,  :player_lfg_bonus_faction_id,             type: :uint32,    blocks: 1
        e   0x9C1,  :player_loot_spec_id,                     type: :uint32,    blocks: 1
        e   0x9C2,  :player_override_zone_pvp_type,           type: :uint32,    blocks: 1
        e   0x9C3,  :player_item_level_delta,                 type: :uint32,    blocks: 1
        e   0x9C4,  :player_bag_slot_flags,                   type: :uint32,    blocks: 1
        e   0x9C8,  :player_bank_bag_slot_flags,              type: :uint32,    blocks: 1
        e   0x9CF,  :player_insert_items_left_to_right,       type: :uint32,    blocks: 1
        e   0x9D0,  :player_quest_completed,                  type: :uint32,    blocks: 1

        x   0xD3A
      end

      table :game_object_fields do
        i   :object_fields

        e   0x000,  :game_object_created_by,                  type: :uint32,    blocks: 1
        e   0x004,  :game_object_display_id,                  type: :uint32,    blocks: 1
        e   0x005,  :game_object_flags,                       type: :uint32,    blocks: 1
        e   0x006,  :game_object_parent_rotation,             type: :uint32,    blocks: 1
        e   0x00A,  :game_object_faction,                     type: :uint32,    blocks: 1
        e   0x00B,  :game_object_level,                       type: :uint32,    blocks: 1
        e   0x00C,  :game_object_bytes_1,                     type: :uint32,    blocks: 1
        e   0x00D,  :game_object_visual_id,                   type: :uint32,    blocks: 1
        e   0x00E,  :game_object_state_spell_visual_id,       type: :uint32,    blocks: 1
        e   0x00F,  :game_object_state_anim_id,               type: :uint32,    blocks: 1
        e   0x010,  :game_object_state_anim_kit_id,           type: :uint32,    blocks: 1
        e   0x011,  :game_object_state_world_effect_id,       type: :uint32,    blocks: 1

        x   0x014
      end

      table :corpse_fields do
        i   :object_fields

        e   0x000,  :corpse_owner,                            type: :uint32,    blocks: 1
        e   0x004,  :corpse_party,                            type: :uint32,    blocks: 1
        e   0x008,  :corpse_display_id,                       type: :uint32,    blocks: 1
        e   0x009,  :corpse_item,                             type: :uint32,    blocks: 1
        e   0x01C,  :corpse_bytes_1,                          type: :uint32,    blocks: 1
        e   0x01D,  :corpse_bytes_2,                          type: :uint32,    blocks: 1
        e   0x01E,  :corpse_flags,                            type: :uint32,    blocks: 1
        e   0x01F,  :corpse_dynamic_flags,                    type: :uint32,    blocks: 1
        e   0x020,  :corpse_faction_template,                 type: :uint32,    blocks: 1

        x   0x020
      end

      table :area_trigger_fields do
        i   :object_fields

        e   0x000,  :area_trigger_override_scale_curve,       type: :uint32,    blocks: 1
        e   0x007,  :area_trigger_caster,                     type: :uint32,    blocks: 1
        e   0x00B,  :area_trigger_duration,                   type: :uint32,    blocks: 1
        e   0x00C,  :area_trigger_time_to_target_scale,       type: :uint32,    blocks: 1
        e   0x00D,  :area_trigger_spell_id,                   type: :uint32,    blocks: 1
        e   0x00E,  :area_trigger_spell_visual_id,            type: :uint32,    blocks: 1
        e   0x00F,  :area_trigger_bounds_radius_2d,           type: :uint32,    blocks: 1
        e   0x010,  :area_trigger_explicit_scale,             type: :uint32,    blocks: 1

        x   0x010
      end
    end
  end
end
