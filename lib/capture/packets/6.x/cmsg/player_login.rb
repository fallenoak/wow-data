module WOW::Capture::Packets::CMSG
  class PlayerLogin < WOW::Capture::Packets::Base
    attr_reader :guid

    def parse!
      @guid = read_packed_guid128
    end

    def update_state!
      player_object = parser.objects.find_or_create(@guid)
      parser.session.player_login!(player_object)
    end
  end
end
