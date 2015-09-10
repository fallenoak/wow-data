module WOW::DB2::Records
  class CreatureDifficulty < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :creature_id],
      [:uint32, :faction_id],
      [:uint32, :expansion],
      [:uint32, :minimum_level],
      [:uint32, :maximum_level],
      [:uint32, :flags_1],
      [:uint32, :flags_2],
      [:uint32, :flags_3],
      [:uint32, :flags_4],
      [:uint32, :flags_5],
    ]
  end
end
