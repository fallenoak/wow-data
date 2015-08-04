module WOW::Capture
  class CombatSession
    attr_reader :attackers, :victims, :participants, :active_participants, :log

    def initialize(parser)
      @parser = parser

      @attackers = []
      @victims = []
      @participants = []
      @active_participants = []

      @log = WOWObject::Utility::Log.new
    end

    def add_attacker(attacker)
      @attackers << attacker if !@attackers.include?(attacker)
      add_participant(attacker)
      add_active_participant(attacker)
    end

    def add_victim(victim)
      @victims << victim if !@victims.include?(victim)
      add_participant(victim)
      add_active_participant(victim)
    end

    def remove_attacker(attacker)
      @attackers.delete(attacker)
      remove_active_participant(attacker) if !@victims.include?(attacker)
      close if @attackers.empty?
    end

    def remove_victim(victim)
      @victims.delete(victim)
      remove_active_participant(victim) if !@attackers.include?(victim)
    end

    def add_participant(participant)
      @participants << participant if !@participants.include?(participant)
    end

    def add_active_participant(participant)
      @active_participants << participant if !@active_participants.include?(participant)
    end

    def remove_active_participant(participant)
      @active_participants.delete(participant)
    end

    def close
      @active_participants = []
      @attackers = []
      @victims = []
    end

    # Represent the combat session as a deterministic number.
    def to_i
      sum = 0

      @participants.each { |p| sum += p.guid.to_i }

      sum
    end

    # Represent the combat session as a hex string.
    def hex
      to_i.to_s(16)
    end

    # Represent the combat session as a truncated hex string of a hash.
    def short_id
      Digest::SHA1.hexdigest(hex)[0, 6]
    end

    def pretty_print
      output = ''

      output << "{combatsession:0x#{short_id}"
      output << " participants:#{@participants.count}"
      output << "}"

      output
    end
  end
end
