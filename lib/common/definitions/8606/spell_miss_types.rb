module WOW::Definitions
  build 8606 do
    table :spell_miss_types do
      e   0,  :none,          tc_value: 'None',         label: 'None'
      e   1,  :miss,          tc_value: 'Miss',         label: 'Miss'
      e   2,  :resist,        tc_value: 'Resist',       label: 'Resist'
      e   3,  :dodge,         tc_value: 'Dodge',        label: 'Dodge'
      e   4,  :parry,         tc_value: 'Parry',        label: 'Parry'
      e   5,  :block,         tc_value: 'Block',        label: 'Block'
      e   6,  :evade,         tc_value: 'Evade',        label: 'Evade'
      e   7,  :immune_1,      tc_value: 'Immune1',      label: 'Immune1'
      e   8,  :immune_2,      tc_value: 'Immune2',      label: 'Immune2'
      e   9,  :deflect,       tc_value: 'Deflect',      label: 'Deflect'
      e   10, :absorb,        tc_value: 'Absorb',       label: 'Absorb'
      e   11, :reflect,       tc_value: 'Reflect',      label: 'Reflect'
    end
  end
end
