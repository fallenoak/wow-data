module WOW::Capture::Packets
  class Unhandled < WOW::Capture::Packets::Base
    def handled?
      false
    end

    def valid?
      true
    end

    private def parse!
      nil
    end
  end
end
