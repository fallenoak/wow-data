module WOW::Capture
  class WOWObject
    attr_reader :guid, :type, :movement

    def initialize(guid, type, movement, values)
      @guid = guid
      @type = type
      @movement = movement
      @values = values
    end

    def update!(updated_values)
      @values.merge!(updated_values)
    end

    def method_missing(method_name)
      @values[method_name]
    end
  end
end
