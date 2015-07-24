module WOW::ADT::Records
  class MVER < WOW::ADT::Records::Base
    FIELDS = [
      [:uint32, :version]
    ]

    attr_reader :version

    def parse
      @version = read_uint32
    end
  end
end
