module WOW::Capture
  module Opcodes
    INVALID_PACKET_CLASS_NAME    = :Invalid
    UNHANDLED_PACKET_CLASS_NAME  = :Unhandled

    # Messages from server
    module SMSG
      DIRECTORY = {
        0x1102 => ['SMSG_AUTH_CHALLENGE',   :AuthChallenge],
        0x0C28 => ['SMSG_ON_MONSTER_MOVE',  :OnMonsterMove]
      }
    end

    # Messages from client
    module CMSG
      DIRECTORY = {
        0x045A => ['CMSG_AUTH_SESSION',     :AuthSession]
      }
    end
  end
end
