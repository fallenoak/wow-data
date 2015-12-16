module WOW::Capture::Packets::Records
  class MovementAreaTriggerSphere < WOW::Capture::Packets::Records::Base
    structure do
      float     :radius
      float     :radius_target
    end
  end
end
