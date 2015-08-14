module WOW::Capture::Definitions
  build 20253 do
    table :instance_types do
      e   0,    :common,        tc_value: 'MAP_COMMON',         label: 'Common'
      e   1,    :instance,      tc_value: 'MAP_INSTANCE',       label: 'Instance'
      e   2,    :raid,          tc_value: 'MAP_RAID',           label: 'Raid'
      e   3,    :battleground,  tc_value: 'MAP_BATTLEGROUND',   label: 'Battleground'
      e   4,    :arena,         tc_value: 'MAP_ARENA',          label: 'Arena'
      e   5,    :scenario,      tc_value: 'MAP_SCENARIO',       label: 'Scenario'
    end
  end
end
