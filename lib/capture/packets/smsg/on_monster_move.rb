module WOW::Capture::Packets::SMSG
  class OnMonsterMove < WOW::Capture::Packets::Base
    attr_reader :guid, :position_x, :position_y, :position_z

    def parse!
      @guid = read_guid128

      @position_x = read_float
      @position_y = read_float
      @position_z = read_float
    end
  end
end
