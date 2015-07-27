module WOW::Capture
  module Opcodes
    DIRECTORY = {
      # Messages from server
      0x1102 => ['SMSG_AUTH_CHALLENGE',   'SMSG::AuthChallenge'],
      0x0C28 => ['SMSG_ON_MONSTER_MOVE',  'SMSG::OnMonsterMove'],

      # Messages from client
      0x045A => ['CMSG_AUTH_SESSION',     'CMSG::AuthSession']
    }
  end
end
