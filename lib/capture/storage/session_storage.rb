module WOW::Capture
  class SessionStorage < Storage::Base
    def player_login!(player_object)
      store(:player, player_object)
      publish(:player_login, player_object)
    end

    def map_change!(map_id)
      store(:current_map_id, map_id)
    end

    def current_map_id
      find(:current_map_id)
    end

    def player
      find(:player)
    end
  end
end
