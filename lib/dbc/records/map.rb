module WOW::DBC::Records
  class Map < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:string, :directory],
      [:uint32, :instance_type],
      [:uint32, :flags],
      [:uint32, :map_type],
      [:uint32, :unk5],
      [:string, :map_name],
      [:uint32, :area_table_id],
      [:string, :map_description_horde],
      [:string, :map_description_alliance],
      [:int32,  :loading_screen_id],
      [:float,  :minimap_icon_scale],
      [:int32,  :corpse_map_id],
      [:float,  :corpse_pos_x],
      [:float,  :corpse_pos_y],
      [:int32,  :time_of_day_override],
      [:uint32, :expansion_id],
      [:uint32, :raid_offset],
      [:uint32, :max_players],
      [:int32,  :parent_map_id],
      [:int32,  :cosmetic_parent_map_id],
      [:uint32, :time_offset]
    ]

    CONTINENT_IDS = [0, 1, 530, 571, 870, 1116]

    module MapTypes
      COMMON = 0
      INSTANCE = 1
      RAID = 2
      BATTLEGROUND = 3
      ARENA = 4
      SCENARIO = 5
    end

    module MapFlags
      GARRISON = 0x4000000
    end

    def dungeon?
      (fields[:instance_type] == MapTypes::INSTANCE || fields[:instance_type] == MapTypes::RAID) && !garrison?
    end

    def nonraid_dungeon?
      fields[:instance_type] == MapTypes::INSTANCE && !garrison?
    end

    def raid_dungeon?
      fields[:instance_type] == MapTypes::RAID && !garrison?
    end

    def battleground?
      fields[:instance_type] == MapTypes::BATTLEGROUND
    end

    def garrison?
      (fields[:flags] & MapFlags::GARRISON) != 0
    end

    def worldmap?
      fields[:instance_type] == MapTypes::COMMON
    end

    def arena?
      fields[:instance_type] == MapTypes::ARENA
    end

    def scenario?
      fields[:instance_type] == MapTypes::SCENARIO
    end

    def continent?
      CONTINENT_IDS.include?(fields[:id])
    end
  end
end
