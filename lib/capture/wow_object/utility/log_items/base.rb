module WOW::Capture::WOWObject::Utility::LogItems
  class Base
    attr_reader :packet_index, :tick, :time

    def initialize(object, packet)
      @object = object
      @packet = packet

      @packet_index = packet.index
      @tick = packet.tick
      @time = packet.time

      parse!

      clear_packet!
    end

    def type
      :base
    end

    private def parse!
    end

    # Remove association with packet to prevent lingering reference.
    private def clear_packet!
      @packet = nil
    end

    def pretty_print
      pretty_prefix
    end

    private def pretty_prefix
      "##{'%-6s' % @packet_index} #{@tick} #{@time} [#{type.to_s.upcase}]"
    end
  end
end
