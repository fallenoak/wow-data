module WOW::Capture::Packets::SMSG
  class AttackStart < WOW::Capture::Packets::Base
    attr_reader :attacker_guid, :victim_guid

    def parse!
      @attacker_guid = read_packed_guid128
      @victim_guid = read_packed_guid128
    end

    def track_references!
      if @attacker_guid.creature?
        add_reference!('Attacker', :attacker, :creature, @attacker_guid.entry_id)
      end

      if @victim_guid.creature?
        add_reference!('Victim', :victim, :creature, @victim_guid.entry_id)
      end
    end

    def update_state!
      attacker_object = parser.objects.find_or_create(@attacker_guid)
      victim_object = parser.objects.find_or_create(@victim_guid)

      attacker_object.attack_start!(self)
    end
  end
end
