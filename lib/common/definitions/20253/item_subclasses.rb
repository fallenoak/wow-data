module WOW::Definitions
  build 20253 do
    namespace :item_subclasses do
      table :consumable do
        e   0,  :consumable,          tc_value: nil,    label: 'Consumable'
        e   1,  :potion,              tc_value: nil,    label: 'Potion'
        e   2,  :elixir,              tc_value: nil,    label: 'Elixir'
        e   3,  :flask,               tc_value: nil,    label: 'Flask'
        e   4,  :scroll,              tc_value: nil,    label: 'Scroll'
        e   5,  :food_drink,          tc_value: nil,    label: 'Food & Drink'
        e   6,  :item_enhancement,    tc_value: nil,    label: 'Item Enhancement'
        e   7,  :bandage,             tc_value: nil,    label: 'Bandage'
        e   8,  :other,               tc_value: nil,    label: 'Other'
      end

      table :container do
        e   0,  :bag,                 tc_value: nil,    label: 'Bag'
        e   1,  :soul_bag,            tc_value: nil,    label: 'Soul Bag'
        e   2,  :herb_bag,            tc_value: nil,    label: 'Herb Bag'
        e   3,  :enchanting_bag,      tc_value: nil,    label: 'Enchanting Bag'
        e   4,  :engineering_bag,     tc_value: nil,    label: 'Engineering Bag'
        e   5,  :gem_bag,             tc_value: nil,    label: 'Gem Bag'
        e   6,  :mining_bag,          tc_value: nil,    label: 'Mining Bag'
        e   7,  :leatherworking_bag,  tc_value: nil,    label: 'Leatherworking Bag'
        e   8,  :inscription_bag,     tc_value: nil,    label: 'Inscription Bag'
        e   9,  :tackle_box,          tc_value: nil,    label: 'Tackle Box'
        e   10, :cooking_bag,         tc_value: nil,    label: 'Cooking Bag'
      end

      table :weapon do
        e   0,  :one_handed_axe,      tc_value: nil,    label: 'Axe'
        e   1,  :two_handed_axe,      tc_value: nil,    label: 'Axe'
        e   2,  :bow,                 tc_value: nil,    label: 'Bow'
        e   3,  :gun,                 tc_value: nil,    label: 'Gun'
        e   4,  :one_handed_mace,     tc_value: nil,    label: 'Mace'
        e   5,  :two_handed_mace,     tc_value: nil,    label: 'Mace'
        e   6,  :polearm,             tc_value: nil,    label: 'Polearm'
        e   7,  :one_handed_sword,    tc_value: nil,    label: 'Sword'
        e   8,  :two_handed_sword,    tc_value: nil,    label: 'Sword'
        e   9,  :obsolete,            tc_value: nil,    label: 'Obsolete'
        e   10, :staff,               tc_value: nil,    label: 'Staff'
        e   11, :one_handed_exotic,   tc_value: nil,    label: 'Exotic'
        e   12, :two_handed_exotic,   tc_value: nil,    label: 'Exotic'
        e   13, :fist_weapon,         tc_value: nil,    label: 'Fist Weapon'
        e   14, :miscellaneous,       tc_value: nil,    label: 'Miscellaneous'
        e   15, :dagger,              tc_value: nil,    label: 'Dagger'
        e   16, :thrown,              tc_value: nil,    label: 'Thrown'
        e   17, :spear,               tc_value: nil,    label: 'Spear'
        e   18, :crossbow,            tc_value: nil,    label: 'Crossbow'
        e   19, :wand,                tc_value: nil,    label: 'Wand'
        e   20, :fishing_pole,        tc_value: nil,    label: 'Fishing Pole'
      end

      table :gem do
        e   0,  :red,                 tc_value: nil,    label: 'Red'
        e   1,  :blue,                tc_value: nil,    label: 'Blue'
        e   2,  :yellow,              tc_value: nil,    label: 'Yellow'
        e   3,  :purple,              tc_value: nil,    label: 'Purple'
        e   4,  :green,               tc_value: nil,    label: 'Green'
        e   5,  :orange,              tc_value: nil,    label: 'Orange'
        e   6,  :meta,                tc_value: nil,    label: 'Meta'
        e   7,  :simple,              tc_value: nil,    label: 'Simple'
        e   8,  :prismatic,           tc_value: nil,    label: 'Prismatic'
        e   9,  :crystal_of_fear,     tc_value: nil,    label: 'Crystal of Fear'
        e   10, :cogwheel,            tc_value: nil,    label: 'Cogwheel'
      end

      table :armor do
        e   0,  :miscellaneous,       tc_value: nil,    label: 'Miscellaneous'
        e   1,  :cloth,               tc_value: nil,    label: 'Cloth'
        e   2,  :leather,             tc_value: nil,    label: 'Leather'
        e   3,  :mail,                tc_value: nil,    label: 'Mail'
        e   4,  :plate,               tc_value: nil,    label: 'Plate'
        e   5,  :cosmetic,            tc_value: nil,    label: 'Cosmetic'
        e   6,  :shield,              tc_value: nil,    label: 'Shield'
        e   7,  :libram,              tc_value: nil,    label: 'Libram'
        e   8,  :idol,                tc_value: nil,    label: 'Idol'
        e   9,  :totem,               tc_value: nil,    label: 'Totem'
        e   10, :sigil,               tc_value: nil,    label: 'Sigil'
        e   11, :relic,               tc_value: nil,    label: 'Relic'
      end

      table :reagent do
        e   0,  :reagent,             tc_value: nil,    label: 'Reagent'
      end

      table :projectile do
        e   0,  :wand,                tc_value: nil,    label: 'Wand (OBSOLETE)'
        e   1,  :bolt,                tc_value: nil,    label: 'Bolt (OBSOLETE)'
        e   2,  :arrow,               tc_value: nil,    label: 'Arrow'
        e   3,  :bullet,              tc_value: nil,    label: 'Bullet'
        e   4,  :thrown,              tc_value: nil,    label: 'Thrown (OBSOLETE)'
      end

      table :trade_good do
        e   0,  :trade_good,          tc_value: nil,    label: 'Trade Good'
        e   1,  :parts,               tc_value: nil,    label: 'Parts'
        e   2,  :explosives,          tc_value: nil,    label: 'Explosive'
        e   3,  :devices,             tc_value: nil,    label: 'Device'
        e   4,  :jewelcrafting,       tc_value: nil,    label: 'Jewelcrafting'
        e   5,  :cloth,               tc_value: nil,    label: 'Cloth'
        e   6,  :leather,             tc_value: nil,    label: 'Leather'
        e   7,  :metal_stone,         tc_value: nil,    label: 'Metal & Stone'
        e   8,  :cooking,             tc_value: nil,    label: 'Cooking'
        e   9,  :herb,                tc_value: nil,    label: 'Herb'
        e   10, :elemental,           tc_value: nil,    label: 'Elemental'
        e   11, :other,               tc_value: nil,    label: 'Other'
        e   12, :enchanting,          tc_value: nil,    label: 'Enchanting'
        e   13, :materials,           tc_value: nil,    label: 'Materials'
        e   14, :item_enchantment,    tc_value: nil,    label: 'Item Enchantment'
        e   15, :weapon_enchantment,  tc_value: nil,    label: 'Weapon Enchantment (OBSOLETE)'
      end

      table :generic do
        e   0,  :generic,             tc_value: nil,    label: 'Generic (OBSOLETE)'
      end

      table :recipe do
        e   0,  :book,                tc_value: nil,    label: 'Book'
        e   1,  :leatherworking,      tc_value: nil,    label: 'Leatherworking'
        e   2,  :tailoring,           tc_value: nil,    label: 'Tailoring'
        e   3,  :engineering,         tc_value: nil,    label: 'Engineering'
        e   4,  :blacksmithing,       tc_value: nil,    label: 'Blacksmithing'
        e   5,  :cooking,             tc_value: nil,    label: 'Cooking'
        e   6,  :alchemy,             tc_value: nil,    label: 'Alchemy'
        e   7,  :first_aid,           tc_value: nil,    label: 'First Aid'
        e   8,  :enchanting,          tc_value: nil,    label: 'Enchanting'
        e   9,  :fishing,             tc_value: nil,    label: 'Fishing'
        e   10, :jewelcrafting,       tc_value: nil,    label: 'Jewelcrafting'
        e   11, :inscription,         tc_value: nil,    label: 'Inscription'
      end

      table :money do
        e   0,  :money,               tc_value: nil,    label: 'Money (OBSOLETE)'
      end

      table :quiver do
        e   0,  :quiver_obsolete,     tc_value: nil,    label: 'Quiver (OBSOLETE)'
        e   2,  :quiver,              tc_value: nil,    label: 'Quiver'
        e   3,  :ammo_pouch,          tc_value: nil,    label: 'Ammo Pouch'
      end

      table :quest do
        e   0,  :quest,               tc_value: nil,    label: 'Quest Item'
      end

      table :key do
        e   0,  :key,                 tc_value: nil,    label: 'Key'
        e   1,  :lockpick,            tc_value: nil,    label: 'Lockpick'
      end

      table :permanent do
        e   0,  :permanent,           tc_value: nil,    label: 'Permanent'
      end

      table :miscellaneous do
        e   0,  :junk,                tc_value: nil,    label: 'Junk'
        e   1,  :reagent,             tc_value: nil,    label: 'Reagent'
        e   2,  :companion_pet,       tc_value: nil,    label: 'Companion Pet'
        e   3,  :holiday,             tc_value: nil,    label: 'Holiday'
        e   4,  :other,               tc_value: nil,    label: 'Other'
        e   5,  :mount,               tc_value: nil,    label: 'Mount'
      end

      table :glyph do
        e   1,  :warrior,             tc_value: nil,    label: 'Warrior'
        e   2,  :paladin,             tc_value: nil,    label: 'Paladin'
        e   3,  :hunter,              tc_value: nil,    label: 'Hunter'
        e   4,  :rogue,               tc_value: nil,    label: 'Rogue'
        e   5,  :priest,              tc_value: nil,    label: 'Priest'
        e   6,  :death_knight,        tc_value: nil,    label: 'Death Knight'
        e   7,  :shaman,              tc_value: nil,    label: 'Shaman'
        e   8,  :mage,                tc_value: nil,    label: 'Mage'
        e   9,  :warlock,             tc_value: nil,    label: 'Warlock'
        e   10, :monk,                tc_value: nil,    label: 'Monk'
        e   11, :druid,               tc_value: nil,    label: 'Druid'
      end

      table :battle_pet do
        e   0,  :battle_pet,          tc_value: nil,    label: 'Battle Pet'
      end

      table :wow_token do
        e   0,  :wow_token,           tc_value: nil,    label: 'WoW Token'
      end
    end
  end
end
