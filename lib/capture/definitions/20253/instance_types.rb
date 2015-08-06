module WOW::Capture::Definitions
  build 20253 do
    table :instance_types do
      e   0,    :common,        tc_value: 'MAP_COMMON'
      e   1,    :instance,      tc_value: 'MAP_INSTANCE'
      e   2,    :raid,          tc_value: 'MAP_RAID'
      e   3,    :battleground,  tc_value: 'MAP_BATTLEGROUND'
      e   4,    :arena,         tc_value: 'MAP_ARENA'
      e   5,    :scenario,      tc_value: 'MAP_SCENARIO'
    end
  end
end
