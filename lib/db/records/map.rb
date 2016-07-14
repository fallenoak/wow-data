module WOW::DB::Records
  class Map < WOW::DB::Records::Base
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
