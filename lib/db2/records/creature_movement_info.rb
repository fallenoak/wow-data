module WOW::DB2::Records
  class CreatureMovementInfo < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :unk_1]
    ]
  end
end
