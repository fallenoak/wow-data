module WOW::Capture::WOWObject::Utility
  class CombatSession
    attr_reader :id, :log, :attacker_guid, :victim_guid

    def initialize(attacker_guid, victim_guid)
      @attacker_guid = attacker_guid
      @victim_guid = victim_guid

      @id = @attacker_guid.to_i ^ @victim_guid.to_i

      @log = Log.new
    end

    def victim?(guid)
      @victim_guid.to_i == guid.to_i
    end

    def attacker?(guid)
      @attacker_guid.to_i == guid.to_i
    end

    def open
    end

    def close(reason)
    end
  end
end
