module WOW::Capture::Storage
  class Base
    def initialize
      @storage = {}
      @subscriptions = {}
    end

    # Subscribe to a given event name.
    def on(event_name, opts = {}, &callback)
      @subscriptions[event_name] = [] if !@subscriptions.has_key?(event_name)
      @subscriptions[event_name] << callback
    end

    # Publish event for a given event name and (optional) object.
    def publish(event_name, object = nil)
      target_subscriptions = @subscriptions[event_name]
      return if target_subscriptions.nil?

      target_subscriptions.each do |subscription|
        if object.nil?
          subscription.call
        else
          subscription.call(object)
        end
      end
    end

    def store(path, object)
      @storage[path] = object
    end

    def find(path)
      @storage[path]
    end
  end
end
