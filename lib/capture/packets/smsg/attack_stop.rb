module WOW::Capture::Packets::SMSG
  class AttackStop < WOW::Capture::Packets::Base
    attr_reader :attacker_guid, :victim_guid

    def parse!
      @attacker_guid = read_packed_guid128
      @victim_guid = read_packed_guid128
      @attacker_dead = read_bit
    end

    def attacker_dead?
      @attacker_dead == true
    end

    def update_state!
      attacker_object = parser.objects.find_or_create(@attacker_guid)
      victim_object = parser.objects.find_or_create(@victim_guid)

      attacker_object.died!(self) if attacker_dead?

      attacker_object.attack_stop!(self)
    end
  end
end
