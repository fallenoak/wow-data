module WOW
  class Stream
    class Error < StandardError; end

    module Errors
      class UnsupportedFormat < Error; end
    end
  end
end
