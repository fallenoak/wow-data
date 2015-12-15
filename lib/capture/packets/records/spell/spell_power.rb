module WOW::Capture::Packets::Records
  class SpellPower < WOW::Capture::Packets::Records::Base
    structure do
      int32     :cost
      uint8     :type
    end
  end
end
