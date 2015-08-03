module WOW::Capture::WOWObject::Utility::LogItems
  class TextEmote < Base
    attr_reader :source, :target, :emote_id, :sound_index

    def type
      :text_emote
    end

    def parse!
      @source = @packet.parser.objects.find(@packet.source_guid)
      @target = @packet.parser.objects.find(@packet.target_guid)
      @emote_id = @packet.emote_id
      @emote_type = @packet.emote_type
      @sound_index = @packet.sound_index
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Target: #{@target ? @target.guid.pretty_print : '?'};"
      output << " Emote ID: #{@emote_id};"
      output << " Emote Type: #{@emote_type};"
      output << " Sound Index: #{@sound_index}"

      output
    end
  end
end
