module WOW::Capture::Packets::Records
  class SpellCast < WOW::Capture::Packets::Records::Base
    structure do
      build 0...16981 do
        guid64    :caster_guid,               packed: true
        guid64    :caster_unit_guid,          packed: true

        build 9056 do
          uint8   :cast_count
        end

        int32     :spell_id

        build 0...9056 do
          opcode :SpellCast do
            uint8 :cast_count
          end
        end

        build 9056 do
          int32   :cast_flags
        end

        build 0...9056 do
          uint16  :cast_flags
        end

        uint32    :cast_time

        build 15005 do
          uint32  :cast_time_2
        end

        opcode :SpellGo do
          uint8   :hit_targets_length

          array   :hit_targets,                 length: proc { hit_targets_length } do
                    struct do
                      guid64  :hit_guid
                    end
                  end

          uint8   :miss_targets_length

          array   :miss_targets,                length: proc { miss_targets_length } do
                    struct do
                      guid64  :miss_guid
                      uint8   :miss_type,       remap: :spell_miss_types
                      uint8   :miss_reflect,    remap: :spell_miss_types, if: proc { miss_type == :reflect }
                    end
                  end
        end

        int32     :target_flags,                flags: :target_flags

        guid64    :target_guid,                 any_flags: [:target_flags, %i(unit corpse_enemy game_object corpse_ally unit_minipet)],
                                                packed: true

        guid64    :item_target_guid,            any_flags: [:target_flags, %i(item trade_item)],
                                                packed: true

        build 10192 do
          guid64  :source_transport_guid,       any_flags: [:target_flags, %i(source_location)],
                                                packed: true
        end

        coord     :source_position,             any_flags: [:target_flags, %i(source_location)],
                                                format: :xyz

        build 9464 do
          guid64  :destination_transport_guid,  any_flags: [:target_flags, %i(destination_location)],
                                                packed: true
        end

        coord     :destination_position,        any_flags: [:target_flags, %i(destination_location)],
                                                format: :xyz
      end

      build 19033 do
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
                    struct do
                      guid128 :hit_guid, packed: true
                    end
                  end

        array     :miss_targets,              length: proc { miss_targets_length } do
                    struct do
                      guid128 :miss_guid, packed: true
                    end
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
end
