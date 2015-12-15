module WOW::Capture::Packets::Records
  class MovementSpline < WOW::Capture::Packets::Records::Base
    structure do
      int32     :id
      coord     :destination,             format: :xyz

      reset_bit_reader

      bit       :move

      halt      if: proc { !move }

      reset_bit_reader

      bits      :flags,                   length: 28 # 28 in 20173; 25 before
      bits      :face_type,               length: 2

      bit       :has_jump_gravity
      bit       :has_special_time

      bits      :mode,                    length: 2

      bit       :has_filter_keys

      uint32    :elapsed
      uint32    :duration

      float     :duration_modifier
      float     :next_duration_modifier

      uint32    :points_length

      coord     :face_spot,               if: proc { face_type == 1 }
      guid128   :face_guid,               if: proc { face_type == 2 }, packed: true
      float     :face_direction,          if: proc { face_type == 3 }

      float     :jump_gravity,            if: proc { has_jump_gravity }

      int32     :special_time,            if: proc { has_special_time }

      uint32    :filter_keys_length,      if: proc { has_filters }

      array     :filter_keys,             length: proc { filter_keys_length } do
                  struct do
                    float :in
                    float :out
                  end
                end

      cond      if: proc { has_filters } do
                  build 20173 do
                    reset_bit_reader
                    bits :filter_flags, length: 2
                  end
                end

      array     :points,                  length: proc { points_length } do
                  coord format: :xyz
                end
    end
  end
end
