module WOW::Capture::Types
  class ObjectUpdate
    attr_reader :type, :size, :blocks

    def initialize(type, size)
      @type = type
      @size = size

      @blocks = {}
    end

    def []=(offset, value)
      @blocks[offset] = value
    end

    def to_s
      output = []

      @blocks.each_pair do |offset, value|
        output << "#{offset}:#{value}"
      end

      "[#{output.join(' ')}]"
    end
  end
end
