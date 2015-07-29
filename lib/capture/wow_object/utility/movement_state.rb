module WOW::Capture::WOWObject::Utility
  class MovementState
    attr_reader :state

    def initialize(state)
      @state = state
      parse!
    end

    def on_transport?
      @on_transport == true
    end

    def has_update?
      @has_update == true
    end

    def you?
      @is_you == true
    end

    private def parse!
      @has_update = state[:has_movement_update]
      @on_transport = state[:has_movement_transport]
      @is_you = state[:this_is_you]
    end
  end
end
