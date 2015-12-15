module WOW::Capture::WOWObject::Utility::LogItems
  class TextEmote < Base
    attr_reader :sender, :target, :emote_id, :sound_index

    def type
      :text_emote
    end

    def parse!
      @sender = packet.parser.objects.find(packet.record.sender_guid)
      @target = packet.parser.objects.find(packet.record.target_guid)
      @emote_id = packet.record.emote_id
      @emote_type = nil
      @sound_index = packet.record.sound_index
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
