module WOW::Capture::Definitions
  build 20253 do
    table :creature_ranks do
      e   0,  :normal,          tc_value: 'Normal'
      e   1,  :elite,           tc_value: 'Elite'
      e   2,  :rare_elite,      tc_value: 'RareElite'
      e   3,  :world_boss,      tc_value: 'WorldBoss'
      e   4,  :rare,            tc_value: 'Rare'
      e   5,  :unknown,         tc_value: 'Unknown'
    end
  end
end
