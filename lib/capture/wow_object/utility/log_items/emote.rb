module WOW::Capture::WOWObject::Utility::LogItems
  class Emote < Base
    attr_reader :emote_id, :sound_index

    def type
      :emote
    end

    def parse!
      @emote_id = packet.record.emote_id
      @emote_type = nil
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Emote ID: #{@emote_id};"
      output << " Emote Type: #{@emote_type}"

      output
    end
  end
end
