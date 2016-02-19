module WOW::Definitions
  build 8606 do
    table :target_flags do
      e   0x00000000,   :self,                  tc_value: 'Self',                 label: 'Self'
      e   0x00000001,   :spell_dynamic_1,       tc_value: 'SpellDynamic1',        label: 'SpellDynamic1'
      e   0x00000002,   :unit,                  tc_value: 'Unit',                 label: 'Unit'
      e   0x00000004,   :unit_raid,             tc_value: 'UnitRaid',             label: 'UnitRaid'
      e   0x00000008,   :unit_party,            tc_value: 'UnitParty',            label: 'UnitParty'
      e   0x00000010,   :item,                  tc_value: 'Item',                 label: 'Item'
      e   0x00000020,   :source_location,       tc_value: 'SourceLocation',       label: 'SourceLocation'
      e   0x00000040,   :destination_location,  tc_value: 'DestinationLocation',  label: 'DestinationLocation'
      e   0x00000080,   :unit_enemy,            tc_value: 'UnitEnemy',            label: 'UnitEnemy'
      e   0x00000100,   :unit_ally,             tc_value: 'UnitAlly',             label: 'UnitAlly'
      e   0x00000200,   :corpse_enemy,          tc_value: 'CorpseEnemy',          label: 'CorpseEnemy'
      e   0x00000400,   :unit_dead,             tc_value: 'UnitDead',             label: 'UnitDead'
      e   0x00000800,   :game_object,           tc_value: 'GameObject',           label: 'GameObject'
      e   0x00001000,   :trade_item,            tc_value: 'TradeItem',            label: 'TradeItem'
      e   0x00002000,   :name_string,           tc_value: 'NameString',           label: 'NameString'
      e   0x00004000,   :game_object_item,      tc_value: 'GameObjectItem',       label: 'GameObjectItem'
      e   0x00008000,   :corpse_ally,           tc_value: 'CorpseAlly',           label: 'CorpseAlly'
      e   0x00010000,   :unit_minipet,          tc_value: 'UnitMinipet',          label: 'UnitMinipet'
      e   0x00020000,   :glyph,                 tc_value: 'Glyph',                label: 'Glyph'
      e   0x00040000,   :destination_target,    tc_value: 'DestinationTarget',    label: 'DestinationTarget'
      e   0x00080000,   :extra_targets,         tc_value: 'ExtraTargets',         label: 'ExtraTargets'
      e   0x00100000,   :unit_passenger,        tc_value: 'UnitPassenger',        label: 'UnitPassenger'
      e   0x00400000,   :unknown_1,             tc_value: 'Unk400000'
      e   0x01000000,   :unknown_2,             tc_value: 'Unk1000000'
      e   0x04000000,   :unknown_3,             tc_value: 'Unk4000000'
      e   0x10000000,   :unknown_4,             tc_value: 'Unk10000000'
      e   0x40000000,   :unknown_5,             tc_value: 'Unk40000000'
    end
  end
end
