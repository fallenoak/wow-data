module WOW::Capture::WOWObject::Utility::LogItems
  class Base
    attr_reader :packet_index, :tick, :time, :context, :embed

    def initialize(object, packet, opts = {})
      @object = object
      @packet = packet

      @packet_index = packet.index
      @tick = packet.tick
      @time = packet.time

      @context = opts.has_key?(:context) ? opts[:context] : nil
      @embed = opts.has_key?(:embed) ? opts[:embed] : nil

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

      output << "##{'%-6s' % @packet_index} #{@tick} #{@time}"
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
  end
end
