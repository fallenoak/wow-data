module WOW::Definitions
  build 8606 do
    table :languages do
      e   -1,   :addon,               tc_value: 'Addon'
      e   0,    :universal,           tc_value: 'Universal'
      e   1,    :orcish,              tc_value: 'Orcish'
      e   2,    :darnassian,          tc_value: 'Darnassian'
      e   3,    :taurahe,             tc_value: 'Taurahe'
      e   6,    :dwarvish,            tc_value: 'Dwarvish'
      e   7,    :common,              tc_value: 'Common'
      e   8,    :demonic,             tc_value: 'Demonic'
      e   9,    :titan,               tc_value: 'Titan'
      e   10,   :thalassian,          tc_value: 'Thalassian'
      e   11,   :draconic,            tc_value: 'Draconic'
      e   12,   :kalimag,             tc_value: 'Kalimag'
      e   13,   :gnomish,             tc_value: 'Gnomish'
      e   14,   :troll,               tc_value: 'Troll'
    end
  end
end
