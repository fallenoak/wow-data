module WOW::DBC::Records
  class GtNpcTotalHpExp2 < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :hp]
    ]
  end
end
