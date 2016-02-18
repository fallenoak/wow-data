module WOW::Capture::Packets
  class Header
    attr_reader :opcode, :index, :direction, :connection_index, :tick, :time, :elapsed_time

    def initialize(attributes = {})
      @index = attributes[:index]
      @connection_index = attributes[:connection_index]

      @tick = attributes[:tick]
      @time = attributes[:time]
      @elapsed_time = attributes[:elapsed_time]

      @direction = attributes[:direction]
      @opcode = attributes[:opcode]
    end

    def to_h
      {
        index: @index,
        connection_index: @connection_index,
        tick: @tick,
        time: @time,
        elapsed_time: @elapsed_time,
        direction: @direction,
        opcode: @opcode ? @opcode.to_h : nil
      }
    end
  end
end
