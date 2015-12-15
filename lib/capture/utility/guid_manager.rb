module WOW::Capture::Utility
  module GuidManager
    @cache128 = {}
    @cache64 = {}

    def self.fetch_guid128(parser, low, high)
      cache_key = [low, high].hash

      guid = @cache128[cache_key]
      return guid if !guid.nil?

      guid = WOW::Capture::Types::Guid128.new(parser, low, high)

      @cache128[cache_key] = guid

      guid
    end

    def self.fetch_guid64(parser, low)
      cache_key = low.hash

      guid = @cache64[cache_key]
      return guid if !guid.nil?

      guid = WOW::Capture::Types::Guid64.new(parser, low)

      @cache64[cache_key] = guid

      guid
    end
  end
end
