module WOW::Capture::Packets::Records
  class MovementVehicleCreate < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :id
      float     :initial_raw_facing
    end
  end
end
