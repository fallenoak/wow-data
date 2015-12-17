module WOW::Capture::Packets::Records
  class Inline < WOW::Capture::Packets::Records::Base
    def initialize(structure, root = nil)
      super()
      @structure = structure
      @root = root || self
    end
  end
end
