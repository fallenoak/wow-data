module WOW::Definitions
  build 19033 do
    table :power_types do
      e   -2, :health,          tc_value: 'Health',         label: 'Health'
      e   0,  :mana,            tc_value: 'Mana',           label: 'Mana'
      e   1,  :rage,            tc_value: 'Rage',           label: 'Rage'
      e   2,  :focus,           tc_value: 'Focus',          label: 'Focus'
      e   3,  :energy,          tc_value: 'Energy',         label: 'Energy'
      e   4,  :happiness,       tc_value: 'Happiness',      label: 'Happiness'      # Removed from >= 4.x
      e   5,  :rune,            tc_value: 'Rune',           label: 'Rune'
      e   6,  :runic_power,     tc_value: 'RunicPower',     label: 'Runic Power'
      e   7,  :soul_shards,     tc_value: 'SoulShards',     label: 'Soul Shards'
      e   8,  :eclipse,         tc_value: 'Eclipse',        label: 'Eclipse'
      e   9,  :holy_power,      tc_value: 'HolyPower',      label: 'Holy Power'
      e   10, :alternate,       tc_value: 'Alternate',      label: 'Alternate'
      e   11, :elusive_brew,    tc_value: 'ElusiveBrew',    label: 'Elusive Brew'   # Added in 5.x
      e   12, :chi,             tc_value: 'Chi',            label: 'Chi'            # Added in 5.x
      e   13, :shadow_orbs,     tc_value: 'ShadowOrbs',     label: 'Shadow Orbs'    # Added in 5.x
      e   14, :burning_embers,  tc_value: 'BurningEmbers',  label: 'Burning Embers' # Added in 5.x
      e   15, :demonic_fury,    tc_value: 'DemonicFury',    label: 'Demonic Fury'   # Added in 5.x
      e   16, :arcane_charge,   tc_value: 'ArcaneCharge',   label: 'Arcane Charge'  # Added in 5.x
    end
  end
end
