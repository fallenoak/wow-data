module WOW::DB2::Records
  class CreatureType < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:string, :name],
      [:uint32, :flags]
    ]
  end
end
