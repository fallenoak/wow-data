module WOW::Capture::Packets::Records
  class MovementUpdate < WOW::Capture::Packets::Records::Base
    structure do
      struct    :status,                  source: :movement_status

      float     :walk_speed,              transform: { divide: 2.5 }
      float     :run_speed,               transform: { divide: 7.0 }
      float     :run_back_speed
      float     :swim_speed
      float     :swim_back_speed
      float     :flight_speed
      float     :flight_back_speed
      float     :turn_rate
      float     :pitch_rate

      int32     :forces_length

      array     :forces,                  length: proc { forces_length } do
                  struct source: :movement_force
                end

      reset_bit_reader

      bit       :has_spline

      struct    :spline,                  if: proc { has_spline }, source: :movement_spline
    end
  end
end
