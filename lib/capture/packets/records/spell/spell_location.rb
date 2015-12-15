module WOW::Capture::Packets::Records
  class SpellLocation < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :transport,     packed: true
      coord     :position,      format: :xyz
    end
  end
end
