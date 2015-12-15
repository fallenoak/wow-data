module WOW::Capture::Packets::SMSG
  class AttackStop < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :attacker_guid,       packed: true
        guid128   :victim_guid,         packed: true

        bit       :attacker_dead
      end

      build 0...15595 do
        guid64    :attacker_guid,       packed: true
        guid64    :victim_guid,         packed: true

        int32     :attacker_dead
      end
    end

    def attacker_dead?
      record.attacker_dead == true || record.attacker_dead == 1
    end

    def track_references!
      if record.attacker_guid.creature?
        add_reference!('Attacker', :attacker, :creature, record.attacker_guid.entry_id)
      end

      if record.victim_guid.creature?
        add_reference!('Victim', :victim, :creature, record.victim_guid.entry_id)
      end
    end

    def update_state!
      attacker_object = parser.objects.find_or_create(record.attacker_guid)
      victim_object = parser.objects.find_or_create(record.victim_guid)

      attacker_object.died!(self) if attacker_dead?

      attacker_object.attack_stop!(self)
    end
  end
end
