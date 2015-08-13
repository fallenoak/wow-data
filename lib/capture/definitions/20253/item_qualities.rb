module WOW::Capture::Definitions
  build 20253 do
    table :item_qualities do
      e   0,  :poor,          tc_value: 'Poor',       label: 'Poor'
      e   1,  :normal,        tc_value: 'Normal',     label: 'Normal'
      e   2,  :uncommon,      tc_value: 'Uncommon',   label: 'Uncommon'
      e   3,  :rare,          tc_value: 'Rare',       label: 'Rare'
      e   4,  :epic,          tc_value: 'Epic',       label: 'Epic'
      e   5,  :legendary,     tc_value: 'Legendary',  label: 'Legendary'
      e   6,  :artifact,      tc_value: 'Artifact',   label: 'Artifact'
      e   7,  :heirloom,      tc_value: 'Heirloom',   label: 'Heirloom'
      e   8,  :wow_token,     tc_value: 'WowToken',   label: 'WoW Token'
    end
  end
end
