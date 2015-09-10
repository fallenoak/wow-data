module WOW::DBC::Records
  class GtOCTBaseHPByClass < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:float,  :ratio]
    ]
  end
end
