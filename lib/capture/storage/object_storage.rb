module WOW::Capture
  class ObjectStorage
    attr_reader :parser

    def initialize(parser)
      @parser = parser
      @storage = {}
      @subscriptions = {}
    end

    # Subscribe to a given event name.
    def on(event_name, opts = {}, &callback)
      @subscriptions[event_name] = [] if !@subscriptions.has_key?(event_name)
      @subscriptions[event_name] << callback
    end

    # Publish for a given event name and object.
    def trigger(event_name, wow_object)
      target_subscriptions = @subscriptions[event_name]
      return if target_subscriptions.nil?

      target_subscriptions.each do |subscription|
        subscription.call(wow_object)
      end
    end

    def store(wow_object)
      wow_object.storage = self
      @storage[wow_object.guid.to_i] = wow_object
    end

    def find(guid)
      @storage[guid.to_i]
    end

    def find_or_create(guid)
      wow_object = find(guid)
      return wow_object if !wow_object.nil?

      # We didn't find the object, so we're creating it manually.
      wow_object = build_from_guid(guid)
      store(wow_object)

      trigger(:create, wow_object)

      wow_object
    end

    def length
      @storage.keys.length
    end

    def first
      last_key = @storage.keys.last
      @storage[last_key]
    end

    def last
      last_key = @storage.keys.last
      @storage[last_key]
    end

    def each(&block)
      @storage.each_pair do |pair|
        block.call(pair[1])
      end
    end

    private def build_from_guid(guid)
      object_class = class_for_guid(guid)
      object = object_class.new(guid)

      object
    end

    private def class_for_guid(guid)
      case guid.type
      when :creature
        WOW::Capture::WOWObject::Creature
      when :player
        WOW::Capture::WOWObject::Player
      else
        WOW::Capture::WOWObject::Base
      end
    end
  end
end
