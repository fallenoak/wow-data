module WOW::DBC::Records
  class GtNpcTotalHpExp3 < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :hp]
    ]
  end
end
