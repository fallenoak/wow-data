module WOW::Capture::WOWObject
  class Base
    attr_reader :guid, :type, :log, :movement, :current_position, :active_combat_sessions

    def initialize(guid)
      @guid = guid
      @type = guid.type
      @object_type = guid.object_type

      @current_position = WOW::Capture::Coordinate.new(nil, nil, nil)

      @log = Utility::Log.new

      @in_combat = false

      @is_spawned = false
      @is_despawned = false
    end

    def storage=(storage)
      @storage = storage
    end

    def parser
      @storage.parser
    end

    def spawned?
      @is_spawned == true
    end

    def despawned?
      @is_spawned == false
    end

    def in_combat?
      @in_combat == true
    end

    def spawn!(packet, raw_movement_state, raw_values_state)
      to_log!(:Spawn, packet, contextual: false)

      @movement = raw_movement_state
      @values = raw_values_state

      @storage.trigger(:spawn, self)
    end

    def despawn!(packet)
      related_combat_sessions(:attacker).each do |combat_session|
        combat_session.remove_attacker(self)
      end

      related_combat_sessions(:victim).each do |combat_session|
        combat_session.remove_victim(self)
      end

      to_log!(:Despawn, packet, contextual: false)

      @storage.trigger(:despawn, self)
    end

    def move!(packet)
      to_log!(:Move, packet)

      @current_position = packet.position

      @storage.trigger(:move, self)
    end

    def text_emote!(packet)
      to_log!(:TextEmote, packet)
    end

    def emote!(packet)
      to_log!(:Emote, packet)
    end

    def chat!(packet)
      to_log!(:Chat, packet)
    end

    def attack_start!(packet)
      attacker = parser.objects.find_or_create(packet.attacker_guid)
      victim = parser.objects.find_or_create(packet.victim_guid)

      relevant_session = parser.combat_sessions.find_by_active_participants(attacker, victim).first
      relevant_session = parser.combat_sessions.create if relevant_session.nil?

      relevant_session.add_attacker(attacker)
      relevant_session.add_victim(victim)

      to_log!(:AttackStart, packet)
    end

    def attack_stop!(packet)
      attacker = parser.objects.find_or_create(packet.attacker_guid)
      victim = parser.objects.find_or_create(packet.victim_guid)

      to_log!(:AttackStop, packet)

      related_combat_sessions(:attacker).each do |session|
        session.remove_attacker(attacker)
      end

      related_combat_sessions(:victim).each do |session|
        session.remove_victim(victim)
      end
    end

    def died!(packet)
      to_log!(:Died, packet)
    end

    def update_values!(updated_values)
      @values.merge!(updated_values)
      @storage.trigger(:update, self)
    end

    def spell_start!(packet)
      to_log!(:SpellStart, packet)
    end

    def spell_go!(packet)
      to_log!(:SpellGo, packet)
    end

    private def related_combat_sessions(mode = :any)
      case mode
      when :attacker
        parser.combat_sessions.find_by_attacker(self)
      when :victim
        parser.combat_sessions.find_by_victim(self)
      else
        parser.combat_sessions.find_by_active_participants(self)
      end
    end

    private def to_log!(item_class_name, packet, opts = {})
      item_class = Utility::LogItems.const_get(item_class_name)
      log_item = item_class.new(self, packet, {})
      log.add(log_item)

      return if opts[:contextual] == false

      related_combat_sessions.each do |combat_session|
        combat_session.log.add(log_item)
      end
    end

    #def method_missing(method_name)
    #  @values[method_name]
    #end
  end
end
