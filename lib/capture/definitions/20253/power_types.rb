module WOW::Capture::Definitions
  build 20253 do
    table :power_types do
      e   -2, :health,          tc_value: 'Health'
      e   0,  :mana,            tc_value: 'Mana'
      e   1,  :rage,            tc_value: 'Rage'
      e   2,  :focus,           tc_value: 'Focus'
      e   3,  :energy,          tc_value: 'Energy'
      e   4,  :happiness,       tc_value: 'Happiness'       # Removed from >= 4.x
      e   5,  :rune,            tc_value: 'Rune'
      e   6,  :runic_power,     tc_value: 'RunicPower'
      e   7,  :soul_shards,     tc_value: 'SoulShards'
      e   8,  :eclipse,         tc_value: 'Eclipse'
      e   9,  :holy_power,      tc_value: 'HolyPower'
      e   10, :alternate,       tc_value: 'Alternate'
      e   11, :elusive_brew,    tc_value: 'ElusiveBrew'     # Added in 5.x
      e   12, :chi,             tc_value: 'Chi'             # Added in 5.x
      e   13, :shadow_orbs,     tc_value: 'ShadowOrbs'      # Added in 5.x
      e   14, :burning_embers,  tc_value: 'BurningEmbers'   # Added in 5.x
      e   15, :demonic_fury,    tc_value: 'DemonicFury'     # Added in 5.x
      e   16, :arcane_charge,   tc_value: 'ArcaneCharge'    # Added in 5.x
    end
  end
end
