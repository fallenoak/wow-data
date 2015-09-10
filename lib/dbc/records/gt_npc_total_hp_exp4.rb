module WOW::DBC::Records
  class GtNpcTotalHpExp4 < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :hp]
    ]
  end
end
