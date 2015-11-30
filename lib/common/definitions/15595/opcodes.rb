module WOW::Definitions
  build 15595 do
    namespace :opcodes do
      table :cmsg do
        # Implemented
        e   0x05B1,   :PlayerLogin,                             tc_value: 'CMSG_PLAYER_LOGIN'
      end

      table :smsg do
        # Implemented
        e   0x4542,   :AuthChallenge,                           tc_value: 'SMSG_AUTH_CHALLENGE'
        e   0x6E17,   :OnMonsterMove,                           tc_value: 'SMSG_ON_MONSTER_MOVE'
        e   0x6024,   :QueryCreatureResponse,                   tc_value: 'SMSG_QUERY_CREATURE_RESPONSE'
      end
    end
  end
end
