module WOW::Capture
  class SessionStorage < Storage::Base
    def player_login!(player_object)
      store(:player, player_object)
      publish(:player_login, player_object)
    end

    def player
      find(:player)
    end
  end
end
