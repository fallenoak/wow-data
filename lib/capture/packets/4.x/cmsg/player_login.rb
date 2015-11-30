module WOW::Capture::Packets::CMSG
  class PlayerLogin < WOW::Capture::Packets::Base
    attr_reader :guid

    def parse!
      if client_build >= 15595
        @guid = read_bitstream_guid64([2, 3, 0, 6, 4, 5, 1, 7], [2, 7, 0, 3, 5, 6, 1, 4])
      elsif client_build >= 15354
        @guid = read_bitstream_guid64([6, 7, 4, 5, 0, 1, 3, 2], [1, 4, 7, 2, 3, 6, 0, 5])
      elsif client_build >= 15005
        @guid = read_bitstream_guid64([0, 5, 3, 4, 7, 6, 2, 1], [4, 1, 7, 2, 6, 5, 3, 0])
      elsif client_build >= 14545
        @guid = read_bitstream_guid64([0, 4, 7, 1, 3, 2, 5, 6], [5, 0, 3, 4, 7, 2, 6, 1])
      else
        @guid = read_guid64
      end
    end

    def update_state!
      player_object = parser.objects.find_or_create(@guid)
      parser.session.player_login!(player_object)
    end
  end
end
