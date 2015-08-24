module WOW::Capture::Packets::SMSG
  class LoginVerifyWorld < WOW::Capture::Packets::Base
    attr_reader :map_id, :position, :reason

    def parse!
      @map_id = read_int32
      @position = read_vector(4)
      @reason = read_uint32
    end

    def update_state!
      parser.session.map_change!(@map_id)
    end
  end
end
