module WOW::Capture::Packets::Records
  class SpellHealPrediction < WOW::Capture::Packets::Records::Base
    structure do
      int32     :points
      uint8     :type
      guid128   :beacon_guid,       packed: true
    end
  end
end
