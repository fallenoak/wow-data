module WOW::Definitions
  build 20253 do
    table :creature_ranks do
      e   0,  :normal,          tc_value: 'Normal',       label: 'Normal'
      e   1,  :elite,           tc_value: 'Elite',        label: 'Elite'
      e   2,  :rare_elite,      tc_value: 'RareElite',    label: 'Rare Elite'
      e   3,  :world_boss,      tc_value: 'WorldBoss',    label: 'World Boss'
      e   4,  :rare,            tc_value: 'Rare',         label: 'Rare'
      e   5,  :unknown_1,       tc_value: 'Unknown',      label: 'Unknown 1'
      e   6,  :unknown_2,       tc_value: nil,            label: 'Unknown 2'
    end
  end
end
