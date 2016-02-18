module WOW::Capture::Packets::Records
  class Root < WOW::Capture::Packets::Records::Base
    attr_reader :packet

    def initialize(packet, structure)
      super()
      @packet = packet
      @structure = structure
    end
  end
end
