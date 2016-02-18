module WOW::Capture::WOWObject::Utility::LogItems
  class Base
    attr_reader :packet_index, :tick, :time, :elapsed_time, :context, :embed, :extras

    def initialize(object, packet, opts = {})
      @object = object
      @packet = packet

      @packet_index = packet.header.index
      @tick = packet.header.tick
      @time = packet.header.time
      @elapsed_time = packet.header.elapsed_time

      @context = opts.has_key?(:context) ? opts.delete(:context) : nil
      @embed = opts.has_key?(:embed) ? opts.delete(:embed) : nil
      @extras = opts

      parse!

      clear_packet!
    end

    def type
      :base
    end

    def context?
      !@context.nil?
    end

    def embed?
      !@embed.nil?
    end

    private def object
      @object
    end

    private def packet
      @packet
    end

    private def parse!
    end

    # Remove association with packet to prevent lingering reference.
    private def clear_packet!
      @packet = nil
    end

    def pretty_print
      embed? ? pretty_embed << pretty_prefix : pretty_prefix
    end

    private def pretty_embed
      output = []

      @embed.items.each do |item|
        output << item.pretty_print
      end

      output = output.join("\n")
      output << "\n" if @embed.items.length > 0

      output
    end

    private def pretty_prefix
      output = ''

      output << "##{'%-6s' % @packet_index} #{pretty_duration(@elapsed_time)}"
      output << " M:#{'%-4s' % @object.guid.map_id}"
      output << " E:#{'%-6s' % @object.guid.entry_id}"
      output << " G:#{@object.guid.short_id}"
      output << ' + ' << ('%-10s' % "<#{@context}>") if context?
      output << ' [ ' << ('%-13s' % "#{type.to_s.upcase}") << ' ]'

      output
    end

    private def pretty_line
      output = ''

      output = "\n" << (' ' * pretty_prefix.length)

      output
    end

    private def pretty_duration(total_seconds)
      milliseconds = (total_seconds.modulo(1).round(3) * 1000).round
      seconds = total_seconds % 60
      minutes = (total_seconds / 60) % 60
      hours = total_seconds / (60 * 60)

      format("%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds)
    end
  end
end
