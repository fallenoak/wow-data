module WOW::Capture::Packets::Records
  class MissileTrajectory < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :travel_time
      float     :pitch
    end
  end
end
