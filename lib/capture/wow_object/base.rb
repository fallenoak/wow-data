module WOW::Capture::WOWObject
  class Base
    attr_reader :guid, :type, :movement, :log, :current_position

    def initialize(guid)
      @guid = guid
      @type = guid.type
      @object_type = guid.object_type

      @current_position = WOW::Capture::Coordinate.new(nil, nil, nil)

      @log = Utility::Log.new
    end

    def initialize_movement_state(raw_movement_state)
      @movement = raw_movement_state
    end

    def initialize_values_state(raw_values_state)
      @values = raw_values_state
    end

    def storage=(storage)
      @storage = storage
    end

    def move!(packet)
      log_item = Utility::LogItems::Move.new(self, packet)
      @log << log_item

      @current_position = packet.position

      @storage.trigger(:move, self)
    end

    def text_emote!(packet)
      log_item = Utility::LogItems::TextEmote.new(self, packet)
      @log << log_item
    end

    def emote!(packet)
      log_item = Utility::LogItems::Emote.new(self, packet)
      @log << log_item
    end

    def chat!(packet)
      log_item = Utility::LogItems::Chat.new(self, packet)
      @log << log_item
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
