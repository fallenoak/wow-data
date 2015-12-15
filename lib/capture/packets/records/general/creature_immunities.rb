module WOW::Capture::Packets::Records
  class CreatureImmunities < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :school
      uint32    :value
    end
  end
end
