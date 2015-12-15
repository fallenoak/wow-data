module WOW::Capture::Packets::Records
  class Root < WOW::Capture::Packets::Records::Base
    def initialize(structure)
      super()
      @structure = structure
    end
  end
end
