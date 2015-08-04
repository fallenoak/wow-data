module WOW::Capture
  class CombatSessionStorage
    attr_reader :parser

    def initialize(parser)
      @parser = parser
      @storage = []
      @subscriptions = {}
    end

    # Returns all combat sessions that include all given participants.
    def find_by_active_participants(*participants)
      matches = []

      @storage.each do |session|
        matched = true

        participants.each do |participant|
          matched = matched && session.active_participants.include?(participant)
        end

        matches << session if matched
      end

      matches
    end

    def find_by_attacker(attacker)
      matches = []

      @storage.each do |session|
        matches << session if session.attackers.include?(attacker)
      end

      matches
    end

    def find_by_victim(attacker)
      matches = []

      @storage.each do |session|
        matches << session if session.victims.include?(attacker)
      end

      matches
    end

    def create
      session = CombatSession.new(@parser)
      @storage << session
      session
    end

    def each(&block)
      @storage.each do |item|
        block.call(item)
      end
    end
  end
end
