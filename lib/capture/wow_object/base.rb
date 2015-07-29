module WOW::Capture::WOWObject
  class Base
    attr_reader :guid, :type, :movement, :log, :current_position

    def initialize(guid, object_type, raw_movement_state, raw_values_state)
      @guid = guid
      @type = guid.type
      @object_type = object_type
      @movement = raw_movement_state
      @values = raw_values_state

      @current_position = WOW::Capture::Coordinate.new(nil, nil, nil)

      @log = Utility::Log.new
    end

    def storage=(storage)
      @storage = storage
    end

    def move!(packet)
      log_item = Utility::LogItems::Moved.new(self, packet)
      @log << log_item

      @current_position = packet.position

      @storage.trigger(:move, self)
    end

    def update_values!(updated_values)
      @values.merge!(updated_values)
      @storage.trigger(:update, self)
    end

    def method_missing(method_name)
      @values[method_name]
    end
  end
end
