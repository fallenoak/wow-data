module WOW::Capture::WOWObject
  class Player < Base
    attr_reader :name, :race, :character_class

    def set_name!(name)
      @name = name
    end

    def set_race!(race)
      @race = race
    end

    def set_character_class!(character_class)
      @character_class = character_class
    end
  end
end
