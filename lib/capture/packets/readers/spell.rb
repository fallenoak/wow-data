module WOW::Capture::Packets::Readers
  module Spell
    def read_spell_cast_data
      @caster_guid = read_packed_guid128
      @caster_unit_guid = read_packed_guid128

      @cast_id = read_byte
      @spell_id = read_int32

      # todo client >= 6.2.0 20173
      @spell_x_spell_visual_id = read_uint32

      @cast_flags = read_uint32
      @cast_time = read_uint32

      hit_targets_count = read_uint32
      miss_targets_count = read_uint32
      miss_status_count = read_uint32

      @spell_target = read_spell_target_data

      remaining_power_count = read_uint32

      @missile_trajectory = read_missile_trajectory_result
      @spell_ammo = read_spell_ammo
      @dest_loc_spell_cast_index = read_byte

      target_points_count = read_uint32

      @creature_immunities = read_creature_immunities
      @spell_heal_prediction = read_spell_heal_prediction

      @hit_targets = []
      @miss_targets = []
      @miss_status = []
      @remaining_power = []
      @target_points = []

      hit_targets_count.times do
        @hit_targets << read_packed_guid128
      end

      miss_targets_count.times do
        @miss_targets << read_packed_guid128
      end

      miss_status_count.times do
        @miss_status << read_spell_miss_status
      end

      remaining_power_count.times do
        @remaining_power << read_spell_power_data
      end

      target_points_count.times do
        @target_points << read_spell_location
      end

      reset_bit_reader

      # todo client >= 6.2.0 20173 ? 20 : 18
      @cast_flags_ex = read_bits(20)

      has_rune_data = read_bit
      has_projectile_visual = false && read_bit # todo client < 6.2.0 20173

      if has_rune_data
        @remaining_runes = read_rune_data
      end

      if has_projectile_visual
        @projectile_visual = read_projectile_visual
      end
    end

    def read_spell_target_data
      data = {}

      reset_bit_reader

      # todo client >= 6.1.0 19678 ? 23 : 21
      data[:flags] = read_bits(23)

      has_src_loc = read_bit
      has_dst_loc = read_bit
      has_orient = read_bit
      name_length = read_bits(7)

      data[:unit] = read_packed_guid128
      data[:item] = read_packed_guid128

      if has_src_loc
        data[:source_location] = read_spell_location
      end

      if has_dst_loc
        data[:destination_location] = read_spell_location
      end

      if has_orient
        data[:orientation] = read_float
      end

      data[:name] = read_char(name_length)

      data
    end

    def read_spell_location
      location = {}

      location[:transport] = read_packed_guid128
      location[:location] = WOW::Capture::Coordinate.new(read_vector(3))

      location
    end

    def read_missile_trajectory_result
      result = {}

      result[:travel_time] = read_uint32
      result[:pitch] = read_float

      result
    end

    def read_spell_ammo
      ammo = {}

      ammo[:display_id] = read_uint32
      ammo[:inventory_type] = read_byte

      ammo
    end

    def read_creature_immunities
      immunities = {}

      immunities[:school] = read_uint32
      immunities[:value] = read_uint32

      immunities
    end

    def read_spell_heal_prediction
      prediction = {}

      prediction[:points] = read_int32
      prediction[:type] = read_byte
      prediction[:beacon_guid] = read_packed_guid128

      prediction
    end

    def read_spell_power_data
      power = {}

      power[:cost] = read_int32
      power[:type] = parser.defs.power_types.find(read_byte)

      power
    end

    def read_spell_miss_status
      status = {}

      reset_bit_reader

      status[:reason] = read_bits(4)

      if status[:reason] == 11
        status[:reflect_status] = read_bits(4)
      end

      status
    end

    def read_rune_data
      runes = {}

      runes[:start] = read_byte
      runes[:count] = read_byte

      reset_bit_reader

      cooldown_count = read_bits(3)

      cooldowns = []

      cooldown_count.times do
        cooldowns << read_byte
      end

      runes[:cooldowns] = cooldowns

      runes
    end
  end
end
