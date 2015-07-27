module WOW::Capture::Packets
  class Invalid < WOW::Capture::Packets::Base
    def handled?
      false
    end

    def valid?
      false
    end
  end
end
