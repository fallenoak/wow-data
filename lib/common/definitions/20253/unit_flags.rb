module WOW::Definitions
  build 20253 do
    table :unit_flags do
      # Basic
      e   0x0,          :none,                                    tc_value: 'None'
      e   0x1,          :not_client_controlled,                   tc_value: 'NotClientControlled'
      e   0x2,          :player_cannot_attack,                    tc_value: 'PlayerCannotAttack'
      e   0x4,          :remove_client_control,                   tc_value: 'RemoveClientControl'
      e   0x8,          :player_controlled,                       tc_value: 'PlayerControlled'
      e   0x10,         :unk_1,                                   tc_value: 'Unk4'
      e   0x20,         :preparation,                             tc_value: 'Preparation'
      e   0x40,         :unk_2,                                   tc_value: 'Unk6'
      e   0x80,         :no_attack,                               tc_value: 'NoAttack'
      e   0x100,        :not_attackable_by_player_controlled,     tc_value: 'NotAttackbleByPlayerControlled'
      e   0x200,        :only_attackable_by_player_controlled,    tc_value: 'OnlyAttackableByPlayerControlled'
      e   0x400,        :looting,                                 tc_value: 'Looting'
      e   0x800,        :pet_is_attacking_target,                 tc_value: 'PetIsAttackingTarget'
      e   0x1000,       :pvp,                                     tc_value: 'PVP'
      e   0x2000,       :silenced,                                tc_value: 'Silenced'
      e   0x4000,       :cannot_swim,                             tc_value: 'CannotSwim'
      e   0x8000,       :only_swim,                               tc_value: 'OnlySwim'
      e   0x10000,      :no_attack_2,                             tc_value: 'NoAttack2'
      e   0x20000,      :pacified,                                tc_value: 'Pacified'
      e   0x40000,      :stunned,                                 tc_value: 'Stunned'
      e   0x80000,      :affecting_combat,                        tc_value: 'AffectingCombat'
      e   0x100000,     :on_taxi,                                 tc_value: 'OnTaxi'
      e   0x200000,     :main_hand_disarmed,                      tc_value: 'MainHandDisarmed'
      e   0x400000,     :confused,                                tc_value: 'Confused'
      e   0x800000,     :feared,                                  tc_value: 'Feared'
      e   0x1000000,    :possessed_by_player,                     tc_value: 'PossessedByPlayer'
      e   0x2000000,    :not_selectable,                          tc_value: 'NotSelectable'
      e   0x4000000,    :skinnable,                               tc_value: 'Skinnable'
      e   0x8000000,    :mount,                                   tc_value: 'Mount'
      e   0x10000000,   :prevent_kneeling_when_looting,           tc_value: 'PreventKneelingWhenLooting'
      e   0x20000000,   :prevent_emotes,                          tc_value: 'PreventEmotes'
      e   0x40000000,   :sheath,                                  tc_value: 'Sheath'
      e   0x80000000,   :unk_3,                                   tc_value: 'Unk31'

      # Combination
      e   0x800 | 0x80000, :in_combat,                            tc_value: 'IsInCombat'
    end
  end
end
