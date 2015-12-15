module WOW::Capture::Packets::Records
  class MovementStationaryPosition < WOW::Capture::Packets::Records::Base
    structure do
      coord   :position,      format: :xyz
      float   :orientation
    end
  end
end
