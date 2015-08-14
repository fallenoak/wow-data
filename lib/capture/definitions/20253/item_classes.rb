module WOW::Capture::Definitions
  build 20253 do
    table :item_classes do
      e   0,  :consumable,    tc_value: 'Consumable',     label: 'Consumable'
      e   1,  :container,     tc_value: 'Container',      label: 'Container'
      e   2,  :weapon,        tc_value: 'Weapon',         label: 'Weapon'
      e   3,  :gem,           tc_value: 'Gem',            label: 'Gem'
      e   4,  :armor,         tc_value: 'Armor',          label: 'Armor'
      e   5,  :reagent,       tc_value: 'Reagent',        label: 'Reagent'
      e   6,  :projectile,    tc_value: 'Projectile',     label: 'Projectile'
      e   7,  :trade_good,    tc_value: 'TradeGoods',     label: 'Trade Good'
      e   8,  :generic,       tc_value: 'Generic',        label: 'Generic'
      e   9,  :recipe,        tc_value: 'Recipe',         label: 'Recipe'
      e   10, :money,         tc_value: 'Money',          label: 'Money'
      e   11, :quiver,        tc_value: 'Quiver',         label: 'Quiver'
      e   12, :quest,         tc_value: 'Quest',          label: 'Quest Item'
      e   13, :key,           tc_value: 'Key',            label: 'Key'
      e   14, :permanent,     tc_value: 'Permanent',      label: 'Permanent'
      e   15, :miscellaneous, tc_value: 'Miscellaneous',  label: 'Miscellaneous'
      e   16, :glyph,         tc_value: 'Glyph',          label: 'Glyph'
      e   17, :battle_pet,    tc_value: 'BattlePets',     label: 'Battle Pet'
      e   18, :wow_token,     tc_value: nil,              label: 'WoW Token'
    end
  end
end
