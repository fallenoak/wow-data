module WOW::Capture::Packets::SMSG
  class PhaseShiftChange < WOW::Capture::Packets::Base
    module Structs
      Phase = Struct.new *%i(flags id)
    end

    attr_reader :client_guid, :personal_guid, :phase_shift_flags, :phases, :preload_map_ids,
      :visible_map_ids, :swap_ui_world_map_area_ids

    def parse!
      @client_guid = read_packed_guid128

      @phase_shift_flags = read_int32

      phases_count = read_int32

      @personal_guid = read_packed_guid128

      @phases = []

      phases_count.times do
        flags = read_int16
        id = read_int16

        phase = Structs::Phase.new(flags, id)

        @phases << phase
      end

      preload_map_ids_count = read_int32 / 2

      @preload_map_ids = []

      preload_map_ids_count.times do
        @preload_map_ids << read_int16
      end

      swap_ui_world_map_area_ids_count = read_int32 / 2

      @swap_ui_world_map_area_ids = []

      swap_ui_world_map_area_ids_count.times do
        @swap_ui_world_map_area_ids << read_int16
      end

      visible_map_ids_count = read_int32 / 2

      @visible_map_ids = []

      visible_map_ids_count.times do
        @visible_map_ids << read_int16
      end
    end

    def update_state!
    end
  end
end
