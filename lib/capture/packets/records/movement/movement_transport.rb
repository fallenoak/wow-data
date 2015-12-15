module WOW::Capture::Packets::Records
  class MovementTransport < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :guid,                    packed: true

      coord     :position,                format: :xyzo

      uint8     :seat_index
      uint32    :move_time

      reset_bit_reader

      bit       :has_previous_move_time
      bit       :has_vehicle_rec_id

      uint32    :previous_move_time,      if: proc { has_previous_move_time }
      int32     :vehicle_rec_id,          if: proc { has_vehicle_rec_id }
    end
  end
end
