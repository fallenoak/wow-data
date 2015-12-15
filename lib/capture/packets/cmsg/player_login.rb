module WOW::Capture::Packets::CMSG
  class PlayerLogin < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :player_guid,     packed: true
      end

      build 18291...19033 do
        float     :unknown_1
        guid64    :player_guid,     bitstream: [[1, 4, 7, 3, 2, 6, 5, 0], [5, 1, 0, 6, 2, 4, 7, 3]]
      end

      build 17898...18291 do
        float     :unknown_1
        guid64    :player_guid,     bitstream: [[7, 6, 0, 4, 5, 2, 3, 1], [5, 0, 1, 6, 7, 2, 3, 4]]
      end

      build 17658...17898 do
        float     :unknown_1
        guid64    :player_guid,     bitstream: [[7, 2, 5, 4, 3, 0, 6, 1], [7, 1, 5, 0, 3, 6, 2, 4]]
      end

      build 15595..15595 do
        guid64    :player_guid,     bitstream: [[2, 3, 0, 6, 4, 5, 1, 7], [2, 7, 0, 3, 5, 6, 1, 4]]
      end

      build 15354...15595 do
        guid64    :player_guid,     bitstream: [[6, 7, 4, 5, 0, 1, 3, 2], [1, 4, 7, 2, 3, 6, 0, 5]]
      end

      build 15005...15354 do
        guid64    :player_guid,     bitstream: [[0, 5, 3, 4, 7, 6, 2, 1], [4, 1, 7, 2, 6, 5, 3, 0]]
      end

      build 14545...15005 do
        guid64    :player_guid,     bitstream: [[0, 4, 7, 1, 3, 2, 5, 6], [5, 0, 3, 4, 7, 2, 6, 1]]
      end

      build 0...14545 do
        guid64    :player_guid
      end
    end

    def update_state!
      player_object = parser.objects.find_or_create(record.player_guid)
      parser.session.player_login!(player_object)
    end
  end
end
