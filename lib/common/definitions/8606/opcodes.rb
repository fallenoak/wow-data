module WOW::Definitions
  build 8606 do
    namespace :opcodes do
      table :cmsg do
        # Implemented
        #e   0x0898,   :PlayerLogin,                             tc_value: 'CMSG_PLAYER_LOGIN'
      end

      table :smsg do
        # Implemented
        #e   0xCA4A,   :AttackStart,                             tc_value: 'SMSG_ATTACK_START'
        #e   0xCED7,   :AttackStop,                              tc_value: 'SMSG_ATTACK_STOP'
        e   0x0096,   :Chat,                                    tc_value: 'SMSG_CHAT'
        #e   0x4542,   :AuthChallenge,                           tc_value: 'SMSG_AUTH_CHALLENGE'
        #e   0x6E17,   :OnMonsterMove,                           tc_value: 'SMSG_ON_MONSTER_MOVE'
        #e   0x6024,   :QueryCreatureResponse,                   tc_value: 'SMSG_QUERY_CREATURE_RESPONSE'
        #e   0x6E04,   :QueryPlayerNameResponse,                 tc_value: 'SMSG_QUERY_PLAYER_NAME_RESPONSE'
      end
    end
  end
end
