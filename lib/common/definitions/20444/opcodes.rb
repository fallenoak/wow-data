module WOW::Definitions
  build 20253 do
    namespace :opcodes do
      table :smsg do
        # Implemented
        e   0x1028,   :AuthChallenge,                           tc_value: 'SMSG_AUTH_CHALLENGE'
        e   0x1299,   :Chat,                                    tc_value: 'SMSG_CHAT'
        e   0x0599,   :Emote,                                   tc_value: 'SMSG_EMOTE'
        e   0x1310,   :OnMonsterMove,                           tc_value: 'SMSG_ON_MONSTER_MOVE'
        e   0x0972,   :LootResponse,                            tc_value: 'SMSG_LOOT_RESPONSE'
        e   0x022A,   :QueryCreatureResponse,                   tc_value: 'SMSG_QUERY_CREATURE_RESPONSE'
        e   0x0B2A,   :QueryPlayerNameResponse,                 tc_value: 'SMSG_QUERY_PLAYER_NAME_RESPONSE'
        e   0x0B23,   :TextEmote,                               tc_value: 'SMSG_TEXT_EMOTE'
        e   0x0C59,   :UpdateObject,                            tc_value: 'SMSG_UPDATE_OBJECT'
        e   0x0F0A,   :AttackStart,                             tc_value: 'SMSG_ATTACK_START'
        e   0x00FC,   :AttackStop,                              tc_value: 'SMSG_ATTACK_STOP'
        e   0x0BA7,   :SpellGo,                                 tc_value: 'SMSG_SPELL_GO'
        e   0x03F5,   :SpellStart,                              tc_value: 'SMSG_SPELL_START'
        e   0x0871,   :PhaseShiftChange,                        tc_value: 'SMSG_PHASE_SHIFT_CHANGE'
        e   0x03AB,   :LoginVerifyWorld,                        tc_value: 'SMSG_LOGIN_VERIFY_WORLD'
        e   0x061E,   :NewWorld,                                tc_value: 'SMSG_NEW_WORLD'
      end

      table :cmsg do
        # Implemented
        e   0x116D,   :AuthSession,                             tc_value: 'CMSG_AUTH_SESSION'
        e   0x03F9,   :PlayerLogin,                             tc_value: 'CMSG_PLAYER_LOGIN'
      end
    end
  end
end
