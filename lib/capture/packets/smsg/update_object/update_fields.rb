module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module UpdateFields
      module ObjectFields
        BASELINE = 0x000
        BOUNDARY = 0x00C

        DEFINITIONS = {
          BASELINE + 0x000 => :object_field_guid,
          BASELINE + 0x004 => :object_field_data,
          BASELINE + 0x008 => :object_field_type,
          BASELINE + 0x009 => :object_field_entry,
          BASELINE + 0x00A => :object_field_dynamic_flags,
          BASELINE + 0x00B => :object_field_scale_x
        }
      end

      module ItemFields
        BASELINE = ObjectFields::BOUNDARY + 0x000
        BOUNDARY = ObjectFields::BOUNDARY + 0x046

        DEFINITIONS = {
          BASELINE + 0x000 => :item_field_owner,
          BASELINE + 0x004 => :item_field_contained,
          BASELINE + 0x008 => :item_field_creator,
          BASELINE + 0x00C => :item_field_giftcreator,
          BASELINE + 0x010 => :item_field_stack_count,
          BASELINE + 0x011 => :item_field_duration,
          BASELINE + 0x012 => :item_field_spell_charges,
          BASELINE + 0x017 => :item_field_flags,
          BASELINE + 0x018 => :item_field_enchantment,
          BASELINE + 0x03F => :item_field_property_seed,
          BASELINE + 0x040 => :item_field_random_properties_id,
          BASELINE + 0x041 => :item_field_durability,
          BASELINE + 0x042 => :item_field_maxdurability,
          BASELINE + 0x043 => :item_field_create_played_time,
          BASELINE + 0x044 => :item_field_modifiers_mask,
          BASELINE + 0x045 => :item_field_context
        }
      end

      module UnitFields
        BASELINE = ObjectFields::BOUNDARY + 0x000
        BOUNDARY = ObjectFields::BOUNDARY + 0x0C8

        DEFINITIONS = {
          BASELINE + 0x000 => :unit_field_charm,
          BASELINE + 0x004 => :unit_field_summon,
          BASELINE + 0x008 => :unit_field_critter,
          BASELINE + 0x00C => :unit_field_charmedby,
          BASELINE + 0x010 => :unit_field_summonedby,
          BASELINE + 0x014 => :unit_field_createdby,
          BASELINE + 0x018 => :unit_field_demon_creator,
          BASELINE + 0x01C => :unit_field_target,
          BASELINE + 0x020 => :unit_field_battle_pet_companion_guid,
          BASELINE + 0x024 => :unit_field_battle_pet_db_id,
          BASELINE + 0x026 => :unit_field_channel_object,
          BASELINE + 0x02A => :unit_channel_spell,
          BASELINE + 0x02B => :unit_channel_spell_x_spell_visual,
          BASELINE + 0x02C => :unit_field_summoned_by_home_realm,
          BASELINE + 0x02D => :unit_field_bytes_0,
          BASELINE + 0x02E => :unit_field_display_power,
          BASELINE + 0x02F => :unit_field_override_display_power_id,
          BASELINE + 0x030 => :unit_field_health,
          BASELINE + 0x031 => :unit_field_power,
          BASELINE + 0x037 => :unit_field_maxhealth,
          BASELINE + 0x038 => :unit_field_maxpower,
          BASELINE + 0x03E => :unit_field_power_regen_flat_modifier,
          BASELINE + 0x044 => :unit_field_power_regen_interrupted_flat_modifier,
          BASELINE + 0x04A => :unit_field_level,
          BASELINE + 0x04B => :unit_field_effective_level,
          BASELINE + 0x04C => :unit_field_factiontemplate,
          BASELINE + 0x04D => :unit_virtual_item_slot_id,
          BASELINE + 0x053 => :unit_field_flags,
          BASELINE + 0x056 => :unit_field_aurastate,
          BASELINE + 0x057 => :unit_field_baseattacktime,
          BASELINE + 0x059 => :unit_field_rangedattacktime,
          BASELINE + 0x05A => :unit_field_boundingradius,
          BASELINE + 0x05B => :unit_field_combatreach,
          BASELINE + 0x05C => :unit_field_displayid,
          BASELINE + 0x05D => :unit_field_nativedisplayid,
          BASELINE + 0x05E => :unit_field_mountdisplayid,
          BASELINE + 0x05F => :unit_field_mindamage,
          BASELINE + 0x060 => :unit_field_maxdamage,
          BASELINE + 0x061 => :unit_field_minoffhanddamage,
          BASELINE + 0x062 => :unit_field_maxoffhanddamage,
          BASELINE + 0x063 => :unit_field_bytes_1,
          BASELINE + 0x064 => :unit_field_petnumber,
          BASELINE + 0x065 => :unit_field_pet_name_timestamp,
          BASELINE + 0x066 => :unit_field_petexperience,
          BASELINE + 0x067 => :unit_field_petnextlevelexp,
          BASELINE + 0x068 => :unit_mod_cast_speed,
          BASELINE + 0x069 => :unit_mod_cast_haste,
          BASELINE + 0x06A => :unit_field_mod_haste,
          BASELINE + 0x06B => :unit_field_mod_ranged_haste,
          BASELINE + 0x06C => :unit_field_mod_haste_regen,
          BASELINE + 0x06D => :unit_created_by_spell,
          BASELINE + 0x06E => :unit_npc_flags,
          BASELINE + 0x070 => :unit_npc_emotestate,
          BASELINE + 0x071 => :unit_field_stat,
          BASELINE + 0x076 => :unit_field_posstat,
          BASELINE + 0x07B => :unit_field_negstat,
          BASELINE + 0x080 => :unit_field_resistances,
          BASELINE + 0x087 => :unit_field_resistancebuffmodspositive,
          BASELINE + 0x08E => :unit_field_resistancebuffmodsnegative,
          BASELINE + 0x095 => :unit_field_mod_bonus_armor,
          BASELINE + 0x096 => :unit_field_base_mana,
          BASELINE + 0x097 => :unit_field_base_health,
          BASELINE + 0x098 => :unit_field_bytes_3,
          BASELINE + 0x099 => :unit_field_attack_power,
          BASELINE + 0x09A => :unit_field_attack_power_mod_pos,
          BASELINE + 0x09B => :unit_field_attack_power_mod_neg,
          BASELINE + 0x09C => :unit_field_attack_power_multiplier,
          BASELINE + 0x09D => :unit_field_ranged_attack_power,
          BASELINE + 0x09E => :unit_field_ranged_attack_power_mod_pos,
          BASELINE + 0x09F => :unit_field_ranged_attack_power_mod_neg,
          BASELINE + 0x0A0 => :unit_field_ranged_attack_power_multiplier,
          BASELINE + 0x0A1 => :unit_field_minrangeddamage,
          BASELINE + 0x0A2 => :unit_field_maxrangeddamage,
          BASELINE + 0x0A3 => :unit_field_power_cost_modifier,
          BASELINE + 0x0AA => :unit_field_power_cost_multiplier,
          BASELINE + 0x0B1 => :unit_field_maxhealthmodifier,
          BASELINE + 0x0B2 => :unit_field_hoverheight,
          BASELINE + 0x0B3 => :unit_field_min_item_level_cutoff,
          BASELINE + 0x0B4 => :unit_field_min_item_level,
          BASELINE + 0x0B5 => :unit_field_maxitemlevel,
          BASELINE + 0x0B6 => :unit_field_wild_battlepet_level,
          BASELINE + 0x0B7 => :unit_field_battlepet_companion_name_timestamp,
          BASELINE + 0x0B8 => :unit_field_interact_spellid,
          BASELINE + 0x0B9 => :unit_field_state_spell_visual_id,
          BASELINE + 0x0BA => :unit_field_state_anim_id,
          BASELINE + 0x0BB => :unit_field_state_anim_kit_id,
          BASELINE + 0x0BC => :unit_field_state_world_effect_id,
          BASELINE + 0x0C0 => :unit_field_scale_duration,
          BASELINE + 0x0C1 => :unit_field_looks_like_mount_id,
          BASELINE + 0x0C2 => :unit_field_looks_like_creature_id,
          BASELINE + 0x0C3 => :unit_field_look_at_controller_id,
          BASELINE + 0x0C4 => :unit_field_look_at_controller_target
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
          BASELINE + 0x00E => :player_guildrank,
          BASELINE + 0x00F => :player_guilddelete_date,
          BASELINE + 0x010 => :player_guildlevel,
          BASELINE + 0x011 => :player_bytes,
          BASELINE + 0x014 => :player_duel_team,
          BASELINE + 0x015 => :player_guild_timestamp,
          BASELINE + 0x016 => :player_quest_log,
          BASELINE + 0x304 => :player_visible_item,
          BASELINE + 0x32A => :player_chosen_title,
          BASELINE + 0x32B => :player_fake_inebriation,
          BASELINE + 0x32C => :player_field_virtual_player_realm,
          BASELINE + 0x32D => :player_field_current_spec_id,
          BASELINE + 0x32E => :player_field_taxi_mount_anim_kit_id,
          BASELINE + 0x32F => :player_field_avg_item_level,
          BASELINE + 0x333 => :player_field_current_battle_pet_breed_quality,
          BASELINE + 0x334 => :player_field_inv_slot_head,
          BASELINE + 0x614 => :player_farsight,
          BASELINE + 0x618 => :player_field_known_titles,
          BASELINE + 0x622 => :player_field_coinage,
          BASELINE + 0x624 => :player_xp,
          BASELINE + 0x625 => :player_next_level_xp,
          BASELINE + 0x626 => :player_skill_lineid,
          BASELINE + 0x7E6 => :player_character_points,
          BASELINE + 0x7E7 => :player_field_max_talent_tiers,
          BASELINE + 0x7E8 => :player_track_creatures,
          BASELINE + 0x7E9 => :player_track_resources,
          BASELINE + 0x7EA => :player_expertise,
          BASELINE + 0x7EB => :player_offhand_expertise,
          BASELINE + 0x7EC => :player_field_ranged_expertise,
          BASELINE + 0x7ED => :player_field_combat_rating_expertise,
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

      def self.field_name_at_index(object_type, field_index)
        field_modules = field_modules_for(object_type)
        field_module = select_field_module(field_modules, field_index)

        field_module.nil? ? nil : find_field_name(field_module, field_index)
      end

      def self.field_modules_for(object_type)
        case object_type
        when :unit
          [ObjectFields, UnitFields]
        when :player
          [ObjectFields, UnitFields, PlayerFields]
        when :item
          [ObjectFields, ItemFields]
        else
          [nil]
        end
      end

      def self.select_field_module(field_modules, field_index)
        return nil if field_modules.length == 1 && field_modules[0].nil?

        field_modules.each do |field_module|
          return field_module if field_index >= field_module::BASELINE && field_index < field_module::BOUNDARY
        end

        nil
      end

      def self.find_field_name(field_module, field_index)
        last_field_name = nil
        last_field_diff = 0

        (field_module::BASELINE...field_module::BOUNDARY).each do |definition_index|
          if field_module::DEFINITIONS[definition_index].nil?
            last_field_diff += 1
          else
            last_field_name = field_module::DEFINITIONS[definition_index]
            last_field_diff = 1
          end

          if definition_index == field_index
            if last_field_name.nil?
              return nil
            elsif last_field_diff < 2
              return last_field_name
            else
              return (last_field_name.to_s << '_' << last_field_diff.to_s).to_sym
            end
          end
        end
      end
    end
  end
end
