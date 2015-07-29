module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module Fields
      module ObjectFields
        BASELINE = 0x000
        BOUNDARY = 0x00C

        DEFINITIONS = {
          BASELINE + 0x000 => :object_guid,
          BASELINE + 0x004 => :object_data,
          BASELINE + 0x008 => :object_type,
          BASELINE + 0x009 => :object_entry,
          BASELINE + 0x00A => :object_dynamic_flags,
          BASELINE + 0x00B => :object_scale_x
        }
      end

      module ItemFields
        BASELINE = ObjectFields::BOUNDARY + 0x000
        BOUNDARY = ObjectFields::BOUNDARY + 0x046

        DEFINITIONS = {
          BASELINE + 0x000 => :item_owner,
          BASELINE + 0x004 => :item_contained,
          BASELINE + 0x008 => :item_creator,
          BASELINE + 0x00C => :item_gift_creator,
          BASELINE + 0x010 => :item_stack_count,
          BASELINE + 0x011 => :item_duration,
          BASELINE + 0x012 => :item_spell_charges,
          BASELINE + 0x017 => :item_flags,
          BASELINE + 0x018 => :item_enchantment,
          BASELINE + 0x03F => :item_property_seed,
          BASELINE + 0x040 => :item_random_properties_id,
          BASELINE + 0x041 => :item_durability,
          BASELINE + 0x042 => :item_max_durability,
          BASELINE + 0x043 => :item_create_played_time,
          BASELINE + 0x044 => :item_modifiers_mask,
          BASELINE + 0x045 => :item_context
        }
      end

      module UnitFields
        BASELINE = ObjectFields::BOUNDARY + 0x000
        BOUNDARY = ObjectFields::BOUNDARY + 0x0C8

        DEFINITIONS = {
          BASELINE + 0x000 => :unit_charm,
          BASELINE + 0x004 => :unit_summon,
          BASELINE + 0x008 => :unit_critter,
          BASELINE + 0x00C => :unit_charmed_by,
          BASELINE + 0x010 => :unit_summoned_by,
          BASELINE + 0x014 => :unit_created_by,
          BASELINE + 0x018 => :unit_demon_creator,
          BASELINE + 0x01C => :unit_target,
          BASELINE + 0x020 => :unit_battle_pet_companion_guid,
          BASELINE + 0x024 => :unit_battle_pet_db_id,
          BASELINE + 0x026 => :unit_channel_object,
          BASELINE + 0x02A => :unit_channel_spell,
          BASELINE + 0x02B => :unit_channel_spell_x_spell_visual,
          BASELINE + 0x02C => :unit_summoned_by_home_realm,
          BASELINE + 0x02D => :unit_bytes_0,
          BASELINE + 0x02E => :unit_display_power,
          BASELINE + 0x02F => :unit_override_display_power_id,
          BASELINE + 0x030 => :unit_health,
          BASELINE + 0x031 => :unit_power,
          BASELINE + 0x037 => :unit_max_health,
          BASELINE + 0x038 => :unit_max_power,
          BASELINE + 0x03E => :unit_power_regen_flat_modifier,
          BASELINE + 0x044 => :unit_power_regen_interrupted_flat_modifier,
          BASELINE + 0x04A => :unit_level,
          BASELINE + 0x04B => :unit_effective_level,
          BASELINE + 0x04C => :unit_faction_template,
          BASELINE + 0x04D => :unit_virtual_item_slot_id,
          BASELINE + 0x053 => :unit_flags,
          BASELINE + 0x056 => :unit_aura_state,
          BASELINE + 0x057 => :unit_base_attack_time,
          BASELINE + 0x059 => :unit_ranged_attack_time,
          BASELINE + 0x05A => :unit_bounding_radius,
          BASELINE + 0x05B => :unit_combat_reach,
          BASELINE + 0x05C => :unit_display_id,
          BASELINE + 0x05D => :unit_native_display_id,
          BASELINE + 0x05E => :unit_mount_display_id,
          BASELINE + 0x05F => :unit_min_damage,
          BASELINE + 0x060 => :unit_max_damage,
          BASELINE + 0x061 => :unit_min_offhand_damage,
          BASELINE + 0x062 => :unit_max_offhand_damage,
          BASELINE + 0x063 => :unit_bytes_1,
          BASELINE + 0x064 => :unit_pet_number,
          BASELINE + 0x065 => :unit_pet_name_timestamp,
          BASELINE + 0x066 => :unit_pet_experience,
          BASELINE + 0x067 => :unit_pet_next_level_exp,
          BASELINE + 0x068 => :unit_mod_cast_speed,
          BASELINE + 0x069 => :unit_mod_cast_haste,
          BASELINE + 0x06A => :unit_mod_haste,
          BASELINE + 0x06B => :unit_mod_ranged_haste,
          BASELINE + 0x06C => :unit_mod_haste_regen,
          BASELINE + 0x06D => :unit_created_by_spell,
          BASELINE + 0x06E => :unit_npc_flags,
          BASELINE + 0x070 => :unit_npc_emotestate,
          BASELINE + 0x071 => :unit_stat,
          BASELINE + 0x076 => :unit_pos_stat,
          BASELINE + 0x07B => :unit_neg_stat,
          BASELINE + 0x080 => :unit_resistances,
          BASELINE + 0x087 => :unit_resistance_buff_mods_positive,
          BASELINE + 0x08E => :unit_resistance_buff_mods_negative,
          BASELINE + 0x095 => :unit_mod_bonus_armor,
          BASELINE + 0x096 => :unit_base_mana,
          BASELINE + 0x097 => :unit_base_health,
          BASELINE + 0x098 => :unit_bytes_3,
          BASELINE + 0x099 => :unit_attack_power,
          BASELINE + 0x09A => :unit_attack_power_mod_pos,
          BASELINE + 0x09B => :unit_attack_power_mod_neg,
          BASELINE + 0x09C => :unit_attack_power_multiplier,
          BASELINE + 0x09D => :unit_ranged_attack_power,
          BASELINE + 0x09E => :unit_ranged_attack_power_mod_pos,
          BASELINE + 0x09F => :unit_ranged_attack_power_mod_neg,
          BASELINE + 0x0A0 => :unit_ranged_attack_power_multiplier,
          BASELINE + 0x0A1 => :unit_min_ranged_damage,
          BASELINE + 0x0A2 => :unit_max_ranged_damage,
          BASELINE + 0x0A3 => :unit_power_cost_modifier,
          BASELINE + 0x0AA => :unit_power_cost_multiplier,
          BASELINE + 0x0B1 => :unit_max_health_modifier,
          BASELINE + 0x0B2 => :unit_hover_height,
          BASELINE + 0x0B3 => :unit_min_item_level_cutoff,
          BASELINE + 0x0B4 => :unit_min_item_level,
          BASELINE + 0x0B5 => :unit_max_item_level,
          BASELINE + 0x0B6 => :unit_wild_battlepet_level,
          BASELINE + 0x0B7 => :unit_battlepet_companion_name_timestamp,
          BASELINE + 0x0B8 => :unit_interact_spell_id,
          BASELINE + 0x0B9 => :unit_state_spell_visual_id,
          BASELINE + 0x0BA => :unit_state_anim_id,
          BASELINE + 0x0BB => :unit_state_anim_kit_id,
          BASELINE + 0x0BC => :unit_state_world_effect_id,
          BASELINE + 0x0C0 => :unit_scale_duration,
          BASELINE + 0x0C1 => :unit_looks_like_mount_id,
          BASELINE + 0x0C2 => :unit_looks_like_creature_id,
          BASELINE + 0x0C3 => :unit_look_at_controller_id,
          BASELINE + 0x0C4 => :unit_look_at_controller_target
        }
      end

      module PlayerFields
        BASELINE = UnitFields::BOUNDARY + 0x000
        BOUNDARY = UnitFields::BOUNDARY + 0xD3B

        DEFINITIONS = {
          BASELINE + 0x000 => :player_duel_arbiter,
          BASELINE + 0x004 => :player_wow_account,
          BASELINE + 0x008 => :player_loot_target_guid,
          BASELINE + 0x00C => :player_flags,
          BASELINE + 0x00D => :player_flags_ex,
          BASELINE + 0x00E => :player_guild_rank,
          BASELINE + 0x00F => :player_guild_delete_date,
          BASELINE + 0x010 => :player_guild_level,
          BASELINE + 0x011 => :player_bytes,
          BASELINE + 0x014 => :player_duel_team,
          BASELINE + 0x015 => :player_guild_timestamp,
          BASELINE + 0x016 => :player_quest_log,
          BASELINE + 0x304 => :player_visible_item,
          BASELINE + 0x32A => :player_chosen_title,
          BASELINE + 0x32B => :player_fake_inebriation,
          BASELINE + 0x32C => :player_virtual_player_realm,
          BASELINE + 0x32D => :player_current_spec_id,
          BASELINE + 0x32E => :player_taxi_mount_anim_kit_id,
          BASELINE + 0x32F => :player_avg_item_level,
          BASELINE + 0x333 => :player_current_battle_pet_breed_quality,
          BASELINE + 0x334 => :player_inv_slot_head,
          BASELINE + 0x614 => :player_farsight,
          BASELINE + 0x618 => :player_known_titles,
          BASELINE + 0x622 => :player_coinage,
          BASELINE + 0x624 => :player_xp,
          BASELINE + 0x625 => :player_next_level_xp,
          BASELINE + 0x626 => :player_skill_lineid,
          BASELINE + 0x7E6 => :player_character_points,
          BASELINE + 0x7E7 => :player_max_talent_tiers,
          BASELINE + 0x7E8 => :player_track_creatures,
          BASELINE + 0x7E9 => :player_track_resources,
          BASELINE + 0x7EA => :player_expertise,
          BASELINE + 0x7EB => :player_offhand_expertise,
          BASELINE + 0x7EC => :player_ranged_expertise,
          BASELINE + 0x7ED => :player_combat_rating_expertise,
          BASELINE + 0x7EE => :player_block_percentage,
          BASELINE + 0x7EF => :player_dodge_percentage,
          BASELINE + 0x7F0 => :player_parry_percentage,
          BASELINE + 0x7F1 => :player_crit_percentage,
          BASELINE + 0x7F2 => :player_ranged_crit_percentage,
          BASELINE + 0x7F3 => :player_offhand_crit_percentage,
          BASELINE + 0x7F4 => :player_spell_crit_percentage,
          BASELINE + 0x7FB => :player_shield_block,
          BASELINE + 0x7FC => :player_shield_block_crit_percentage
        }
      end
    end
  end
end
