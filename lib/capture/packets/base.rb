module WOW::Capture::Packets
  class Base
    attr_reader :direction, :connection_index, :tick, :time, :data

    def initialize(direction, connection_index, tick, time, data)
      @direction = direction
      @connection_index = connection_index
      @tick = tick
      @time = time

      @data = StringIO.new(data)

      parse!
    end

    def parse!
    end
  end
end
