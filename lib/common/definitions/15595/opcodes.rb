module WOW::Definitions
  build 15595 do
    namespace :opcodes do
      table :smsg do
        # Implemented
        e   0x4542,   :AuthChallenge,                           tc_value: 'SMSG_AUTH_CHALLENGE'
        e   0x6E17,   :OnMonsterMove,                           tc_value: 'SMSG_ON_MONSTER_MOVE'
      end
    end
  end
end
