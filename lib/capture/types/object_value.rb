module WOW::Capture::Types
  class ObjectValue
    BLOCK_FORMAT = 'I<*'.freeze

    attr_reader :type, :size, :blocks

    def initialize(parser, update)
      @parser = parser

      @type = update.type
      @size = update.size

      @blocks = []

      @size.times do |block_index|
        @blocks << update.blocks[block_index] || 0
      end

      @updated = true
    end

    def value
      parse! if updated?

      @value
    end

    # Updates can be sparse, so ensure only given block offsets are updated.
    def update!(update)
      update.blocks.each_pair do |block_offset, block_value|
        @blocks[block_offset] = block_value
      end

      @updated = true
    end

    private def updated?
      @updated == true
    end

    private def parse!
      @stream = WOW::Capture::Stream.new(@parser, @blocks.pack(BLOCK_FORMAT))
      @value = @stream.send("read_#{type}")

      @updated = false
    end

    def inspect
      excluded_variables = [:@parser, :@stream]
      all_variables = instance_variables
      variables = all_variables - excluded_variables

      prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

      parts = []

      variables.each do |var|
        parts << "#{var}=#{instance_variable_get(var).inspect}"
      end

      str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

      str
    end
  end
end
