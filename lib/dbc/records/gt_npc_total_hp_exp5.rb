module WOW::DBC::Records
  class GtNpcTotalHpExp5 < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :hp]
    ]
  end
end
