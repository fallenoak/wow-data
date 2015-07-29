module WOW::Capture
  class Storage
    def initialize
      @storage = {}
    end

    def save(wow_object)
      @storage[wow_object.guid.to_i] = wow_object
    end

    def destroy(wow_object_or_guid)
      if wow_object_or_guid.is_a?(WOW::Capture::WOWObject)
        @storage.delete(wow_object_or_guid.guid.to_i)
      else
        @storage.delete(wow_object_or_guid.to_i)
      end
    end

    def find(guid)
      @storage[guid.to_i]
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
  end
end
