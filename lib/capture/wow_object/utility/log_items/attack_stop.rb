module WOW::Capture::WOWObject::Utility::LogItems
  class AttackStop < Base
    attr_reader :attacker, :victim

    def type
      :attack_stop
    end

    def parse!
      @attacker = packet.parser.objects.find_or_create(packet.record.attacker_guid)
      @victim = packet.parser.objects.find_or_create(packet.record.victim_guid)
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Attacker: #{@attacker.guid.pretty_print}"
      output << pretty_line
      output << " Victim:   #{@victim.guid.pretty_print}"

      output
    end
  end
end
