module WOW::Capture::Packets::Records
  class SpellCast < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :caster_guid,               packed: true
      guid128   :caster_unit_guid,          packed: true

      uint8     :cast_id
      int32     :spell_id

      uint32    :spell_x_spell_visual_id

      uint32    :cast_flags
      uint32    :cast_time

      uint32    :hit_targets_length
      uint32    :miss_targets_length
      uint32    :miss_status_length

      struct    :spell_target,              source: :spell_target

      uint32    :remaining_power_length

      struct    :missile_trajectory,        source: :missile_trajectory
      struct    :spell_ammo,                source: :spell_ammo

      uint8     :dest_loc_spell_cast_index

      uint32    :target_points_length

      struct    :creature_immunities,       source: :creature_immunities
      struct    :spell_heal_prediction,     source: :spell_heal_prediction

      array     :hit_targets,               length: proc { hit_targets_length } do
                  guid128 packed: true
                end

      array     :miss_targets,              length: proc { miss_targets_length } do
                  guid128 packed: true
                end

      array     :miss_status,               length: proc { miss_status_length } do
                  struct source: :spell_miss_status
                end

      array     :remaining_power,           length: proc { remaining_power_length } do
                  struct source: :spell_power
                end

      array     :target_points,             length: proc { target_points_length } do
                  struct source: :spell_location
                end

      reset_bit_reader

      bits      :cast_flags_ex,             length: 20

      bit       :has_rune_data

      struct    :remaining_runes,           if: proc { has_rune_data }, source: :spell_runes

      struct    :projectile_visual,         if: proc { has_projectile_visual }, source: :spell_projectile_visual
    end
  end
end
