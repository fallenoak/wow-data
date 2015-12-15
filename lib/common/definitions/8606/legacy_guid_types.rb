module WOW::Definitions
  build 8606 do
    namespace :legacy_guid_types do
      table :high do
        e   -1,     :none,                tc_value: 'None'
        e   0x000,  :player,              tc_value: 'Player'
        e   0x101,  :battleground_1,      tc_value: 'BattleGround1'
        e   0x104,  :instance_save,       tc_value: 'InstanceSave'
        e   0x105,  :group,               tc_value: 'Group'
        e   0x109,  :battleground_2,      tc_value: 'BattleGround2'
        e   0x10C,  :mo_transport,        tc_value: 'MOTransport'
        e   0x10F,  :guild,               tc_value: 'Guild'
        e   0x400,  :item,                tc_value: 'Item'              # Container
        e   0xF00,  :dynamic_object,      tc_value: 'DynObject'         # Corpses
        e   0xF01,  :game_object,         tc_value: 'GameObject'
        e   0xF02,  :transport,           tc_value: 'Transport'
        e   0xF03,  :unit,                tc_value: 'Unit'
        e   0xF04,  :pet,                 tc_value: 'Pet'
        e   0xF05,  :vehicle,             tc_value: 'Vehicle'
      end
    end
  end
end
