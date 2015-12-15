module WOW::Capture::Packets::Records
  class MovementState < WOW::Capture::Packets::Records::Base
    structure do
      reset_bit_reader

      bit       :no_birth_anim
      bit       :enable_portals
      bit       :player_hover_anim
      bit       :is_suppressing_greetings

      bit       :has_update
      bit       :has_transport
      bit       :has_stationary_position
      bit       :has_combat_victim
      bit       :has_server_time
      bit       :has_vehicle_create
      bit       :has_anim_kit_create
      bit       :has_rotation
      bit       :has_area_trigger
      bit       :has_game_object

      bit       :this_is_you
      bit       :replace_active
      bit       :scene_obj_create
      bit       :scene_pending_instances

      uint32    :pause_times_length

      struct    :update,                    if:       proc { has_update },
                                            source:   :movement_update

      struct    :transport,                 if:       proc { has_transport },
                                            source:   :movement_transport

      struct    :stationary_position,       if:       proc { has_stationary_position },
                                            source:   :movement_stationary_position

      guid128   :combat_victim_guid,        if:       proc { has_combat_victim },
                                            packed:   true

      time      :server_time,               if:       proc { has_server_time },
                                            packed:   true

      struct    :vehicle_create,            if:       proc { has_vehicle_create },
                                            source:   :movement_vehicle_create

      struct    :anim_kit_create,           if:       proc { has_anim_kit_create },
                                            source:   :movement_anim_kit_create

      qtern     :rotation,                  if:       proc { has_rotation },
                                            packed:   true

      struct    :area_trigger,              if:       proc { has_area_trigger },
                                            source:   :movement_area_trigger

      struct    :game_object,               if:       proc { has_game_object },
                                            source:   :movement_game_object

      struct    :scene_obj,                 if:       proc { scene_obj_create },
                                            source:   :movement_scene_obj

      struct    :scene_pending_instances,   if:       proc { scene_pending_instances },
                                            source:   :movement_scene_pending_instances

      array     :pause_times,               length:   proc { pause_times_length } do
                  int32
                end
    end
  end
end
