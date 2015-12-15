module WOW::Capture::Packets::SMSG
  class AttackStart < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :attacker_guid,       packed: true
        guid128   :victim_guid,         packed: true
      end

      build 13329..15595 do
        guid64    :attacker_guid
        guid64    :victim_guid
      end
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

      attacker_object.attack_start!(self)
    end
  end
end
