module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module Entries
      module Readers
        private def read_movements
          movements = {}

          @packet.reset_bit_reader

          movements[:no_birth_anim] = @packet.read_bit
          movements[:enable_portals] = @packet.read_bit
          movements[:player_hover_anim] = @packet.read_bit
          movements[:is_suppressing_greetings] = @packet.read_bit

          movements[:has_movement_update] = @packet.read_bit
          movements[:has_movement_transport] = @packet.read_bit
          movements[:has_stationary_position] = @packet.read_bit
          movements[:has_combat_victim] = @packet.read_bit
          movements[:has_server_time] = @packet.read_bit
          movements[:has_vehicle_create] = @packet.read_bit
          movements[:has_anim_kit_create] = @packet.read_bit
          movements[:has_rotation] = @packet.read_bit
          movements[:has_area_trigger] = @packet.read_bit
          movements[:has_game_object] = @packet.read_bit

          movements[:this_is_you] = @packet.read_bit
          movements[:replace_active] = @packet.read_bit

          movements[:scene_obj_create] = @packet.read_bit
          movements[:scene_pending_instances] = @packet.read_bit

          movements[:pause_times_count] = @packet.read_uint32

          if movements[:has_movement_update]
            movements[:movement_update] = read_movement_update
          end

          if movements[:has_movement_transport]
            movements[:movement_transport] = read_movement_transport
          end

          if movements[:has_stationary_position]
            movements[:position] = @packet.read_vector(3)
            movements[:orientation] = @packet.read_float
          end

          if movements[:has_combat_victim]
            movements[:combat_victim_guid] = @packet.read_packed_guid128
          end

          if movements[:has_server_time]
            movements[:server_time] = @packet.read_packed_time
          end

          if movements[:has_vehicle_create]
            movements[:vehicle_id] = @packet.read_uint32
            movements[:vehicle_initial_raw_facing] = @packet.read_float
          end

          if movements[:has_anim_kit_create]
            movements[:ai_id] = @packet.read_uint16
            movements[:movement_id] = @packet.read_uint16
            movements[:melee_id] = @packet.read_uint16
          end

          if movements[:has_rotation]
            movements[:rotation] = @packet.read_packed_quaternion
          end

          if movements[:has_area_trigger]
            area_trigger = {}

            area_trigger[:elapsed_ms] = @packet.read_int32

            area_trigger[:roll_pitch_yaw1] = @packet.read_float
            area_trigger[:roll_pitch_yaw2] = @packet.read_float
            area_trigger[:roll_pitch_yaw3] = @packet.read_float

            @packet.reset_bit_reader

            area_trigger[:has_absolute_orientation] = @packet.read_bit
            area_trigger[:has_dynamic_shape] = @packet.read_bit
            area_trigger[:has_attached] = @packet.read_bit
            area_trigger[:has_face_movement_dir] = @packet.read_bit
            area_trigger[:has_follows_terrain] = @packet.read_bit

            # Min WOD 6_2_0_20173
            area_trigger[:unk_bit_wod62_1] = @packet.read_bit

            area_trigger[:has_target_roll_pitch_yaw] = @packet.read_bit
            area_trigger[:has_scale_curve_id] = @packet.read_bit
            area_trigger[:has_morph_curve_id] = @packet.read_bit
            area_trigger[:has_facing_curve_id] = @packet.read_bit
            area_trigger[:has_move_curve_id] = @packet.read_bit
            area_trigger[:has_area_trigger_sphere] = @packet.read_bit
            area_trigger[:has_area_trigger_box] = @packet.read_bit
            area_trigger[:has_area_trigger_polygon] = @packet.read_bit
            area_trigger[:has_area_trigger_cylinder] = @packet.read_bit
            area_trigger[:has_area_trigger_spline] = @packet.read_bit

            if area_trigger[:has_target_roll_pitch_yaw]
              area_trigger[:target_roll_pitch_yaw_1] = @packet.read_float
              area_trigger[:target_roll_pitch_yaw_2] = @packet.read_float
              area_trigger[:target_roll_pitch_yaw_3] = @packet.read_float
            end

            if area_trigger[:has_scale_curve_id]
              area_trigger[:scale_curve_id] = @packet.read_int32
            end

            if area_trigger[:has_morph_curve_id]
              area_trigger[:morph_curve_id] = @packet.read_int32
            end

            if area_trigger[:has_facing_curve_id]
              area_trigger[:facing_curve_id] = @packet.read_int32
            end

            if area_trigger[:has_move_curve_id]
              area_trigger[:move_curve_id] = @packet.read_int32
            end

            if area_trigger[:has_area_trigger_sphere]
              area_trigger[:radius] = @packet.read_float
              area_trigger[:radius_target] = @packet.read_float
            end

            if area_trigger[:has_area_trigger_box]
              area_trigger[:trigger_box_extents] = @packet.read_vector(3)
              area_trigger[:trigger_box_extents_target] = @packet.read_vector(3)
            end

            if area_trigger[:has_area_trigger_polygon]
              #todo store this

              verticies_count = @packet.read_int32
              verticies_target_count = @packet.read_int32

              height = @packet.read_float
              height_target = @packet.read_float

              # Verticies
              (0...verticies_count).each do |i|
                @packet.read_float
                @packet.read_float
              end

              # Verticies Target
              (0...verticies_count).each do |i|
                @packet.read_float
                @packet.read_float
              end
            end

            if area_trigger[:has_area_trigger_cylinder]
              #todo store this

              radius = @packet.read_float
              radius_target = @packet.read_float
              height = @packet.read_float
              height_target = @packet.read_float
              float4 = @packet.read_float
              float5 = @packet.read_float
            end

            if area_trigger[:has_area_trigger_spline]
              raise "ASDASD!"

              #todo read_area_trigger_spline
            end

            movements[:area_trigger] = area_trigger
          end

          if movements[:has_game_object]
            game_object = {}

            game_object[:world_effect_id] = @packet.read_int32

            @packet.reset_bit_reader

            game_object[:bit8] = @packet.read_bit

            if game_object[:bit8]
              game_object[:int1] = @packet.read_int32
            end

            movements[:game_object] = game_object
          end

          if movements[:scene_obj_create]
            scene_obj = {}

            @packet.reset_bit_reader

            scene_obj[:has_scene_local_script_data] = @packet.read_bit
            scene_obj[:has_pet_battle_full_update] = @packet.read_bit

            if scene_obj[:has_scene_local_script_data]
              @packet.reset_bit_reader

              data_length = @packet.read_bits(7)
              data = @packet.read_char(data_length)

              scene_obj[:local_script_data] = data
            end

            if scene_obj[:pet_battle_full_update]
              raise "FRARZED"
              #todo pet_battle = packet.read_pet_battle_full_update
            end

            movements[:scene_obj] = scene_obj
          end

          if movements[:scene_pending_instances]
            scene_instance_ids_count = @packet.read_int32
            scene_instance_ids = []

            scene_instance_ids_count.times do
              scene_instance_ids << @packet.read_int32
            end

            movements[:scene_instance_ids] = scene_instance_ids
          end

          pause_times = []

          movements[:pause_times_count].times do
            pause_times << @packet.read_int32
          end

          movements[:pause_times] = pause_times

          movements
        end

        private def read_movement_status
          movement_status = {}

          movement_status[:guid] = @packet.read_packed_guid128

          movement_status[:move_index] = @packet.read_uint32
          movement_status[:position_x] = @packet.read_float
          movement_status[:position_y] = @packet.read_float
          movement_status[:position_z] = @packet.read_float

          movement_status[:orientation] = @packet.read_float

          movement_status[:pitch] = @packet.read_float
          movement_status[:step_up_start_elevation] = @packet.read_float

          int152 = @packet.read_int32
          int168 = @packet.read_int32

          remove_forces_ids = []

          (0...int152).each do |i|
            remove_forces_ids << @packet.read_packed_guid128
          end

          movement_status[:remove_forces_ids] = remove_forces_ids

          @packet.reset_bit_reader

          movement_status[:movement_flags] = @packet.read_bits(30)
          movement_status[:movement_flags_extra] = @packet.read_bits(16) # 15 prior to 20173

          movement_status[:has_transport] = @packet.read_bit
          movement_status[:has_fall_data] = @packet.read_bit
          movement_status[:has_spline] = @packet.read_bit
          movement_status[:height_change_failed] = @packet.read_bit
          movement_status[:remote_time_valid] = @packet.read_bit

          if movement_status[:has_transport]
            transport = {}

            transport[:guid] = @packet.read_packed_guid128
            transport[:position] = @packet.read_vector(4)
            transport[:seat] = @packet.read_byte #ReadSByte?
            transport[:time] = @packet.read_int32

            @packet.reset_bit_reader

            transport[:has_prev_move_time] = @packet.read_bit
            transport[:has_vehicle_rec_id] = @packet.read_bit

            if transport[:has_prev_move_time]
              transport[:prev_move_time] = @packet.read_uint32
            end

            if transport[:has_vehicle_rec_id]
              transport[:vehicle_rec_id] = @packet.read_uint32
            end
          end

          if movement_status[:has_fall_data]
            fall_data = {}

            fall_data[:fall_time] = @packet.read_uint32
            fall_data[:jump_velocity] = @packet.read_float

            @packet.reset_bit_reader

            fall_data[:has_fall_direction] = @packet.read_bit

            if fall_data[:has_fall_direction]
              fall_direction = {}

              fall_direction[:fall] = @packet.read_vector(2)
              fall_direction[:horizontal_speed] = @packet.read_float

              fall_data[:fall_direction] = fall_direction
            end

            movement_status[:fall_data] = fall_data
          end

          movement_status
        end

        private def read_movement_update
          movement_update = {}

          movement_update[:movement_status] = read_movement_status

          movement_update[:walk_speed] = @packet.read_float / 2.5
          movement_update[:run_speed] = @packet.read_float / 7.0
          movement_update[:run_back_speed] = @packet.read_float
          movement_update[:swim_speed] = @packet.read_float
          movement_update[:swim_back_speed] = @packet.read_float
          movement_update[:flight_speed] = @packet.read_float
          movement_update[:flight_back_speed] = @packet.read_float
          movement_update[:turn_rate] = @packet.read_float
          movement_update[:pitch_rate] = @packet.read_float

          movement_update[:movement_force_count] = @packet.read_int32

          movement_forces = []

          (0...movement_update[:movement_force_count]).each do |i|
            movement_force = {}

            movement_force[:guid] = @packet.read_packed_guid128
            movement_force[:direction] = @packet.read_vector(3)

            # 19802 (in theory)
            movement_force[:transport_position] = @packet.read_vector(3)

            movement_force[:transport_id] = @packet.read_int32
            movement_force[:magnitude] = @packet.read_float
            movement_force[:type] = @packet.read_byte

            movement_forces << movement_force
          end

          movement_update[:movement_forces] = movement_forces

          @packet.reset_bit_reader

          movement_update[:has_movement_spline] = @packet.read_bit

          if movement_update[:has_movement_spline]
            spline = {}

            spline[:id] = @packet.read_int32
            spline[:destination] = @packet.read_vector(3)

            @packet.reset_bit_reader

            spline[:move] = @packet.read_bit

            if spline[:move]
              @packet.reset_bit_reader

              spline[:flags] = @packet.read_bits(28) # 28 in 20173; 25 before
              spline[:face] = @packet.read_bits(2)

              spline[:has_jump_gravity] = @packet.read_bit
              spline[:has_special_time] = @packet.read_bit

              spline[:mode] = @packet.read_bits(2)

              spline[:has_spline_filter_key] = @packet.read_bit

              spline[:elapsed] = @packet.read_uint32
              spline[:duration] = @packet.read_uint32

              spline[:duration_modifier] = @packet.read_float
              spline[:next_duration_modifier] = @packet.read_float

              spline[:points_count] = @packet.read_uint32

              if spline[:face] == 3
                spline[:face_direction] = @packet.read_float
              end

              if spline[:face] == 2
                spline[:face_guid] = @packet.read_packed_guid128
              end

              if spline[:face] == 1
                spline[:face_spot] = @packet.read_vector(3)
              end

              if spline[:has_jump_gravity]
                spline[:jump_gravity] = @packet.read_float
              end

              if spline[:has_special_time]
                spline[:special_time] = @packet.read_int32
              end

              if spline[:has_spline_filter_key]
                spline[:filter_keys_count] = @packet.read_uint32

                filter_keys = []

                (0...spline[:filter_keys_count]).each do |i|
                  filter_key = {}

                  filter_key[:in] = @packet.read_float
                  filter_key[:out] = @packet.read_float

                  filter_keys << filter_key
                end

                spline[:filter_keys] = filter_keys

                # 20173
                @packet.reset_bit_reader
                spline[:filter_flags] = @packet.read_bits(2)
              end

              points = []

              (0...spline[:points_count]).each do |i|
                point = @packet.read_vector(3)
                points << point
              end

              spline[:points] = points
            end

            movement_update[:movement_spline] = spline
          end

          movement_update
        end

        private def read_movement_transport
          movement_transport = {}

          movement_transport[:guid] = @packet.read_packed_guid128
          movement_transport[:offset] = @packet.read_vector(4)
          movement_transport[:vehicle_seat_index] = @packet.read_byte
          movement_transport[:move_time] = @packet.read_uint32

          @packet.reset_bit_reader

          movement_transport[:has_prev_move_time] = @packet.read_bit
          movement_transport[:has_vehicle_rec_id] = @packet.read_bit

          if movement_transport[:has_prev_move_time]
            movement_transport[:prev_move_time] = @packet.read_uint32
          end

          if movement_transport[:has_vehicle_rec_id]
            movement_transport[:vehicle_rec_id] = @packet.read_int32
          end

          movement_transport
        end

        private def read_values
          updates = {}

          mask_size = @packet.read_byte

          mask_values = []

          mask_size.times do
            mask_values << @packet.read_uint32
          end

          mask = BitArray.new(mask_size, mask_values)

          fields_count = mask.total_set
          fields_found = 0
          field_index = 0

          while fields_found < fields_count
            if mask[field_index] == 0
              field_index += 1
              next
            end

            block_value = @packet.read_update_field

            field_name = FieldManager.field_name_at_index(@object_type, field_index)
            field_name = "field-#{field_index}" if field_name.nil?

            updates[field_name] = block_value

            field_index += 1
            fields_found += 1
          end

          # Newer than 16016
          # ClientVersion.AddedInVersion(ClientVersionBuild.V5_0_4_16016)
          dynamic_updates = read_dynamic_values
          updates.merge!(dynamic_updates)

          # Think we might have to write a bitarray lib ourselves.
          # negative numbers?

          #save_pos = @packet.pos
          #puts "NEXT 32 BYTES WOULD BE: #{@packet.read_char(32).inspect}"
          #@packet.pos = save_pos

          updates
        end

        private def read_dynamic_values
          dynamic = {}

          mask_size = @packet.read_byte

          mask_values = []

          mask_size.times do
            mask_values << @packet.read_uint32
          end

          mask = BitArray.new(mask_size, mask_values)

          fields_count = mask.total_set
          fields_found = 0
          field_index = 0

          while fields_found < fields_count
            if mask[field_index] == 0
              field_index += 1
              next
            end

            flag = @packet.read_byte

            if (flag & 0x80) != 0
              packet.read_uint16
            end

            count = flag & 0x7F

            values = []

            count.times do
              values << @packet.read_uint32
            end

            field_index += 1
            fields_found += 1

            values_mask = BitArray.new(values.length, values)

            values_count = values_mask.total_set
            values_found = 0
            values_index = 0

            while values_found < values_count
              if values_mask[values_index] == 0
                values_index += 1
                next
              end

              block_value = @packet.read_update_field

              values_index += 1
              values_found += 1
            end
          end

          dynamic
        end
      end
    end
  end
end
