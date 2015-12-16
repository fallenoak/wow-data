module WOW::Capture::Packets::Records
  class MovementAreaTrigger < WOW::Capture::Packets::Records::Base
    structure do
      int32     :elapsed_ms
      vector    :roll_pitch_yaw,              length: 3

      reset_bit_reader

      bit       :has_absolute_orientation
      bit       :has_dynamic_shape
      bit       :has_attached
      bit       :has_face_movement_direction
      bit       :has_follows_terrain

      build 20173 do
        bit     :unknown_1
      end

      bit       :has_target_roll_pitch_yaw
      bit       :has_scale_curve_id
      bit       :has_morph_curve_id
      bit       :has_facing_curve_id
      bit       :has_move_curve_id

      bit       :has_area_trigger_sphere
      bit       :has_area_trigger_box
      bit       :has_area_trigger_polygon
      bit       :has_area_trigger_cylinder
      bit       :has_area_trigger_spline

      vector    :target_roll_pitch_yaw,       if: proc { has_target_roll_pitch_yaw }
      int32     :scale_curve_id,              if: proc { has_scale_curve_id }
      int32     :morph_curve_id,              if: proc { has_morph_curve_id }
      int32     :facing_curve_id,             if: proc { has_facing_curve_id }
      int32     :move_curve_id,               if: proc { has_move_curve_id }

      struct    :area_trigger_sphere,         if: proc { has_area_trigger_sphere },
                                              source: :movement_area_trigger_sphere

      struct    :area_trigger_box,            if: proc { has_area_trigger_box },
                                              source: :movement_area_trigger_box

      struct    :area_trigger_polygon,        if: proc { has_area_trigger_polygon },
                                              source: :movement_area_trigger_polygon

      struct    :area_trigger_cylinder,       if: proc { has_area_trigger_cylinder },
                                              source: :movement_area_trigger_cylinder

      struct    :area_trigger_spline,         if: proc { has_area_trigger_spline },
                                              source: :movement_area_trigger_spline
    end
  end
end
