module WOW::Definitions
  build 13329 do
    table :classes do
      e   0,  :none,          tc_value: 'None',         label: 'None'
      e   1,  :warrior,       tc_value: 'Warrior',      label: 'Warrior'
      e   2,  :paladin,       tc_value: 'Paladin',      label: 'Paladin'
      e   3,  :hunter,        tc_value: 'Hunter',       label: 'Hunter'
      e   4,  :rogue,         tc_value: 'Rogue',        label: 'Rogue'
      e   5,  :priest,        tc_value: 'Priest',       label: 'Priest'
      e   6,  :death_knight,  tc_value: 'DeathKnight',  label: 'Death Knight'
      e   7,  :shaman,        tc_value: 'Shaman',       label: 'Shaman'
      e   8,  :mage,          tc_value: 'Mage',         label: 'Mage'
      e   9,  :warlock,       tc_value: 'Warlock',      label: 'Warlock'
      e   10, :monk,          tc_value: 'Monk',         label: 'Monk'
      e   11, :druid,         tc_value: 'Druid',        label: 'Druid'
    end
  end
end
