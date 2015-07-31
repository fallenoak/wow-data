module WOW::Capture::WOWObject
  attr_reader :name

  class Player < Base
    def set_name!(name)
      @name = name
    end
  end
end
