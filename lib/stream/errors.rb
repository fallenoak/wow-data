module WOW
  class Stream
    class Error < StandardError; end

    module Errors
      class UnknownFormat < Error; end
    end
  end
end
