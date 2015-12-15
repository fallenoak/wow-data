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

      @size.times do |block_index|
        output << "#{block_index}:#{@blocks[block_index] || 0}"
      end

      "[#{output.join('; ')}]"
    end
  end
end
