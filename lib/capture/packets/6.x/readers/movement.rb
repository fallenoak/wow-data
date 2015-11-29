module WOW::Capture::Packets::Readers
  module Movement
    module Structs
      Transport           = Struct.new *%i(
        guid offset vehicle_seat_index move_time prev_move_time vehicle_rec_id
      )

      Force               = Struct.new *%i(
        guid direction transport_position transport_id magnitude type
      )

      Spline              = Struct.new *%i(
        id destination move flags face_type face_direction face_guid face_spot jump_gravity
        special_time mode filter_keys filter_flags elapsed duration duration_modifier
        next_duration_modifier points
      )

      Status              = Struct.new *%i(
        guid move_index position orientation pitch step_up_start_elevation remove_force_guids
        flags flags_extra transport height_change_failed remote_time_valid fall_data
      )

      FallData            = Struct.new *%i(
        fall_time jump_velocity fall_direction
      )

      Update              = Struct.new *%i(
        status forces spline walk_speed run_speed run_back_speed swim_speed swim_back_speed
        flight_speed flight_back_speed turn_rate pitch_rate
      )

      Stationary          = Struct.new *%i(
        position orientation
      )

      AreaTrigger         = Struct.new *%i(
        elapsed_ms roll_pitch_yaw target_roll_pitch_yaw scale_curve_id morph_curve_id
        facing_curve_id move_curve_id sphere box polygon cylinder spline
      )

      AreaTriggerSphere   = Struct.new *%i(
        radius radius_target
      )

      AreaTriggerBox      = Struct.new *%i(
        extents extents_target
      )

      AreaTriggerPolygon  = Struct.new *%i(
        height height_target verticies verticies_target
      )

      AreaTriggerCylinder = Struct.new *%i(
        height height_target radius radius_target float_4 float_5
      )

      State               = Struct.new *%i(
        no_birth_anim enable_portals player_hover_anim is_suppressing_greetings this_is_you
        replace_active update transport stationary_position combat_victim_guid server_time
        vehicle anim_kit rotation area_trigger game_object scene_obj scene_instance_ids
        pause_times
      )
    end

    def read_movement_transport
      transport = Structs::Transport.new

      transport.guid = read_packed_guid128
      transport.offset = read_vector(4)
      transport.vehicle_seat_index = read_byte
      transport.move_time = read_uint32

      reset_bit_reader

      has_prev_move_time = read_bit
      has_vehicle_rec_id = read_bit

      if has_prev_move_time
        transport.prev_move_time = read_uint32
      end

      if has_vehicle_rec_id
        transport.vehicle_rec_id = read_int32
      end

      transport
    end

    def read_movement_force
      force = Structs::Force.new

      force.guid = read_packed_guid128
      force.direction = read_vector(3)

      # 19802 (in theory)
      force.transport_position = read_vector(3)

      force.transport_id = read_int32
      force.magnitude = read_float
      force.type = read_byte

      force
    end

    def read_movement_spline
      spline = Structs::Spline.new

      spline.id = read_int32
      spline.destination = read_vector(3)

      reset_bit_reader

      spline.move = read_bit

      # Nothing else to do.
      if !spline.move
        return spline
      end

      reset_bit_reader

      spline.flags = read_bits(28) # 28 in 20173; 25 before
      spline.face_type = read_bits(2)

      has_jump_gravity = read_bit
      has_special_time = read_bit

      spline.mode = read_bits(2)

      has_spline_filter_key = read_bit

      spline.elapsed = read_uint32
      spline.duration = read_uint32

      spline.duration_modifier = read_float
      spline.next_duration_modifier = read_float

      points_count = read_uint32

      if spline.face_type == 3
        spline.face_direction = read_float
      end

      if spline.face_type == 2
        spline.face_guid = read_packed_guid128
      end

      if spline.face_type == 1
        spline.face_spot = read_vector(3)
      end

      if has_jump_gravity
        spline.jump_gravity = read_float
      end

      if has_special_time
        spline.special_time = read_int32
      end

      if has_spline_filter_key
        filter_keys_count = read_uint32

        filter_keys = []

        filter_keys_count.times do
          filter_key = {}

          filter_key[:in] = read_float
          filter_key[:out] = read_float

          filter_keys << filter_key
        end

        spline.filter_keys = filter_keys

        # 20173
        reset_bit_reader
        spline.filter_flags = read_bits(2)
      end

      points = []

      points_count.times do
        point = read_vector(3)
        points << point
      end

      spline.points = points

      spline
    end

    def read_movement_fall_data
      fall_data = Structs::FallData.new

      fall_data.fall_time = read_uint32
      fall_data.jump_velocity = read_float

      reset_bit_reader

      has_fall_direction = read_bit

      if has_fall_direction
        fall_direction = {}

        fall_direction[:fall] = read_vector(2)
        fall_direction[:horizontal_speed] = read_float

        fall_data.fall_direction = fall_direction
      end

      fall_data
    end

    def read_movement_update
      update = Structs::Update.new

      update.status = read_movement_status

      update.walk_speed = read_float / 2.5
      update.run_speed = read_float / 7.0
      update.run_back_speed = read_float
      update.swim_speed = read_float
      update.swim_back_speed = read_float
      update.flight_speed = read_float
      update.flight_back_speed = read_float
      update.turn_rate = read_float
      update.pitch_rate = read_float

      movement_force_count = read_int32

      movement_forces = []

      movement_force_count.times do
        movement_forces << read_movement_force
      end

      update.forces = movement_forces

      reset_bit_reader

      has_movement_spline = read_bit

      if has_movement_spline
        update.spline = read_movement_spline
      end

      update
    end

    def read_movement_status
      status = Structs::Status.new

      status.guid = read_packed_guid128

      status.move_index = read_uint32
      status.position = WOW::Capture::Coordinate.new(read_vector(3))
      status.orientation = read_float

      status.pitch = read_float
      status.step_up_start_elevation = read_float

      int152 = read_int32
      int168 = read_int32

      remove_force_guids = []

      (0...int152).each do |i|
        remove_force_guids << read_packed_guid128
      end

      status.remove_force_guids = remove_force_guids

      reset_bit_reader

      status.flags = read_bits(30)
      status.flags_extra = read_bits(16) # 15 prior to 20173

      has_transport = read_bit
      has_fall_data = read_bit
      has_spline = read_bit

      status.height_change_failed = read_bit
      status.remote_time_valid = read_bit

      if has_transport
        status.transport = read_movement_transport
      end

      if has_fall_data
        status.fall_data = read_movement_fall_data
      end

      status
    end

    def read_movement_stationary
      position = Structs::Stationary.new

      position.position = read_vector(3)
      position.orientation = read_float

      position
    end

    def read_movement_area_trigger_sphere
      sphere = Structs::AreaTriggerSphere.new

      sphere.radius = read_float
      sphere.radius_target = read_float

      sphere
    end

    def read_movement_area_trigger_box
      box = Structs::AreaTriggerBox.new

      box.extents = read_vector(3)
      box.extents_target = read_vector(3)

      box
    end

    def read_movement_area_trigger_polygon
      polygon = Structs::AreaTriggerPolygon.new

      verticies_count = read_int32
      verticies_target_count = read_int32

      polygon.height = read_float
      polygon.height_target = read_float

      verticies = []
      verticies_target = []

      verticies_count.times do
        verticies << read_vector(2)
      end

      verticies_target_count.times do
        verticies_target << read_vector(2)
      end

      polygon.verticies = verticies
      polygon.verticies_target = verticies_target

      polygon
    end

    def read_movement_area_trigger_cylinder
      cylinder = Structs::AreaTriggerCylinder.new

      cylinder.radius = read_float
      cylinder.radius_target = read_float
      cylinder.height = read_float
      cylinder.height_target = read_float
      cylinder.float_4 = read_float
      cylinder.float_5 = read_float

      cylinder
    end

    def read_movement_area_trigger
      area_trigger = Structs::AreaTrigger.new

      area_trigger.elapsed_ms = read_int32
      area_trigger.roll_pitch_yaw = read_vector(3)

      reset_bit_reader

      has_absolute_orientation = read_bit
      has_dynamic_shape = read_bit
      has_attached = read_bit
      has_face_movement_dir = read_bit
      has_follows_terrain = read_bit

      # Min WOD 6_2_0_20173
      unk_bit_wod62_1 = read_bit

      has_target_roll_pitch_yaw = read_bit
      has_scale_curve_id = read_bit
      has_morph_curve_id = read_bit
      has_facing_curve_id = read_bit
      has_move_curve_id = read_bit
      has_area_trigger_sphere = read_bit
      has_area_trigger_box = read_bit
      has_area_trigger_polygon = read_bit
      has_area_trigger_cylinder = read_bit
      has_area_trigger_spline = read_bit

      if has_target_roll_pitch_yaw
        area_trigger.target_roll_pitch_yaw = read_vector(3)
      end

      if has_scale_curve_id
        area_trigger.scale_curve_id = read_int32
      end

      if has_morph_curve_id
        area_trigger.morph_curve_id = read_int32
      end

      if has_facing_curve_id
        area_trigger.facing_curve_id = read_int32
      end

      if has_move_curve_id
        area_trigger.move_curve_id = read_int32
      end

      if has_area_trigger_sphere
        area_trigger.sphere = read_movement_area_trigger_sphere
      end

      if has_area_trigger_box
        area_trigger.box = read_movement_area_trigger_box
      end

      if has_area_trigger_polygon
        area_trigger.polygon = read_movement_area_trigger_polygon
      end

      if has_area_trigger_cylinder
        area_trigger.cylinder = read_movement_area_trigger_cylinder
      end

      if has_area_trigger_spline
        raise "ASDASD!"

        #todo read_area_trigger_spline
      end

      area_trigger
    end

    def read_movement_state
      state = Structs::State.new

      reset_bit_reader

      state.no_birth_anim = read_bit
      state.enable_portals = read_bit
      state.player_hover_anim = read_bit
      state.is_suppressing_greetings = read_bit

      has_movement_update = read_bit
      has_movement_transport = read_bit
      has_stationary_position = read_bit
      has_combat_victim = read_bit
      has_server_time = read_bit
      has_vehicle_create = read_bit
      has_anim_kit_create = read_bit
      has_rotation = read_bit
      has_area_trigger = read_bit
      has_game_object = read_bit

      state.this_is_you = read_bit
      state.replace_active = read_bit

      scene_obj_create = read_bit
      scene_pending_instances = read_bit

      pause_times_count = read_uint32

      if has_movement_update
        state.update = read_movement_update
      end

      if has_movement_transport
        state.transport = read_movement_transport
      end

      if has_stationary_position
        state.stationary_position = read_movement_stationary
      end

      if has_combat_victim
        state.combat_victim_guid = read_packed_guid128
      end

      if has_server_time
        state.server_time = read_packed_time
      end

      if has_vehicle_create
        vehicle = {}

        vehicle[:id] = read_uint32
        vehicle[:initial_raw_facing] = read_float

        state.vehicle = vehicle
      end

      if has_anim_kit_create
        anim_kit = {}

        anim_kit[:ai_id] = read_uint16
        anim_kit[:movement_id] = read_uint16
        anim_kit[:melee_id] = read_uint16

        state.anim_kit = anim_kit
      end

      if has_rotation
        state.rotation = read_packed_quaternion
      end

      if has_area_trigger
        state.area_trigger = read_movement_area_trigger
      end

      if has_game_object
        game_object = {}

        game_object[:world_effect_id] = read_int32

        reset_bit_reader

        game_object[:bit8] = read_bit

        if game_object[:bit8]
          game_object[:int1] = read_int32
        end

        state.game_object = game_object
      end

      if scene_obj_create
        scene_obj = {}

        reset_bit_reader

        scene_obj[:has_scene_local_script_data] = read_bit
        scene_obj[:has_pet_battle_full_update] = read_bit

        if scene_obj[:has_scene_local_script_data]
          reset_bit_reader

          data_length = read_bits(7)
          data = read_char(data_length)

          scene_obj[:local_script_data] = data
        end

        if scene_obj[:has_pet_battle_full_update]
          scene_obj[:pet_battle_full_update] = read_pet_battle_full_update
        end

        state.scene_obj = scene_obj
      end

      if scene_pending_instances
        scene_instance_ids_count = read_int32
        scene_instance_ids = []

        scene_instance_ids_count.times do
          scene_instance_ids << read_int32
        end

        state.scene_instance_ids = scene_instance_ids
      end

      pause_times = []

      pause_times_count.times do
        pause_times << read_int32
      end

      state.pause_times = pause_times

      state
    end
  end
end
