module WOW::Capture::Packets::Records
  class Inline < WOW::Capture::Packets::Records::Base
    def initialize(structure)
      super()
      @structure = structure
    end
  end
end
