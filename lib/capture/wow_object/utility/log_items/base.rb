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
      output = ''

      output << "##{'%-6s' % @packet_index} #{@tick} #{@time}"
      output << " M:#{'%-4s' % @object.guid.map_id}"
      output << " E:#{'%-6s' % @object.guid.entry_id}"
      output << " G:#{@object.guid.hex_id}"
      output << ' [ ' << ('%-10s' % "#{type.to_s.upcase}") << ' ]'

      output
    end
  end
end
