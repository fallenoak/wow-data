module WOW::BLTE
  class Error < StandardError; end

  module Errors
    class UnknownEncoding < Error
    end

    class InvalidChecksum < Error
      def initialize(expected, actual)
        @expected = expected
        @actual = actual
      end

      def to_s
        "Invalid checksum; expected: #{@expected}; actual: #{@actual}"
      end
    end

    class InvalidDecodedSize < Error
      def initialize(expected, actual)
        @expected = expected
        @actual = actual
      end

      def to_s
        "Invalid decoded size; expected: #{@expected}; actual: #{@actual}"
      end
    end
  end
end
