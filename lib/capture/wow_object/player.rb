module WOW::Capture::WOWObject
  attr_reader :name, :race

  class Player < Base
    def set_name!(name)
      @name = name
    end

    def set_race!(race)
      @race = race
    end
  end
end
