module WOW::Definitions
  build 15005 do
    namespace :opcodes do
      table :cmsg do
        # Implemented
        e   0x0326,   :PlayerLogin,                             tc_value: 'CMSG_PLAYER_LOGIN'
      end

      table :smsg do
        # Implemented
        #e   0xCA4A,   :AttackStart,                             tc_value: 'SMSG_ATTACK_START'
        #e   0xCED7,   :AttackStop,                              tc_value: 'SMSG_ATTACK_STOP'
        e   0x3884,   :Chat,                                    tc_value: 'SMSG_CHAT'
        e   0x5E20,   :QueryPlayerNameResponse,                 tc_value: 'SMSG_QUERY_PLAYER_NAME_RESPONSE'
      end
    end
  end
end
