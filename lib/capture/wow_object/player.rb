module WOW::Capture::WOWObject
  class Player < Base
    attr_reader :name, :race

    def set_name!(name)
      @name = name
    end

    def set_race!(race)
      @race = race
    end
  end
end
