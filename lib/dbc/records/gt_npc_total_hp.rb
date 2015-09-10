module WOW::DBC::Records
  class GtNpcTotalHp < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :hp]
    ]
  end
end
