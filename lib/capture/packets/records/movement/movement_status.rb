module WOW::Capture::Packets::Records
  class MovementStatus < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :guid,                      packed: true

      uint32    :move_index

      coord     :position,                  format: :xyz
      float     :orientation

      float     :pitch
      float     :step_up_start_elevation

      int32     :remove_force_guids_length
      int32     :unknown_1

      array     :remove_force_guids,        length: proc { remove_force_guids_length } do
                  guid128 packed: true
                end

      reset_bit_reader

      bits      :flags_1,                   length: 30
      bits      :flags_2,                   length: 16 # 15 prior to 20173

      bit       :has_transport
      bit       :has_fall_data
      bit       :has_spline

      bit       :height_change_failed
      bit       :remote_time_valid

      struct    :transport,                 if: proc { has_transport }, source: :movement_transport
      struct    :fall_data,                 if: proc { has_fall_data }, source: :movement_fall_data
    end
  end
end
