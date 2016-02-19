module WOW::Capture::Types
  class ObjectUpdate
    attr_reader :type, :size, :blocks, :value

    def initialize(type, size)
      @type = type
      @size = size
      @value = nil

      @blocks = {}
    end

    def []=(offset, value)
      @blocks[offset] = value
    end

    def value=(value)
      @value = value
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
