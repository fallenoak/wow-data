module WOW::Capture::Packets::Records
  class MovementFallData < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :fall_time
      float     :jump_velocity

      reset_bit_reader

      bit       :has_fall_direction

      struct    :fall_direction,        if: proc { has_fall_direction } do
                  vector  :fall, length: 2
                  float   :horizontal_speed
                end
    end
  end
end
