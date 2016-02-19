module WOW::Definitions
  build 16309 do
    namespace :opcodes do
      table :cmsg do
        # Implemented
        #e   0x05B1,   :PlayerLogin,                             label: 'CMSG_PLAYER_LOGIN'
      end

      table :smsg do
        # Implemented
        e   0x0009,   :Chat,                                    label: 'SMSG_CHAT'
        #e   0x2D15,   :AttackStart,                             label: 'SMSG_ATTACK_START'
        #e   0x0934,   :AttackStop,                              label: 'SMSG_ATTACK_STOP'
        #e   0x4542,   :AuthChallenge,                           label: 'SMSG_AUTH_CHALLENGE'
        #e   0x6E17,   :OnMonsterMove,                           label: 'SMSG_ON_MONSTER_MOVE'
        #e   0x6024,   :QueryCreatureResponse,                   label: 'SMSG_QUERY_CREATURE_RESPONSE'
        #e   0x6E04,   :QueryPlayerNameResponse,                 label: 'SMSG_QUERY_PLAYER_NAME_RESPONSE'
      end
    end
  end
end
