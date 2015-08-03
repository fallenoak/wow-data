module WOW::Capture::WOWObject
  class Base
    attr_reader :guid, :type, :log, :movement, :current_position, :active_combat_session

    def initialize(guid)
      @guid = guid
      @type = guid.type
      @object_type = guid.object_type

      @current_position = WOW::Capture::Coordinate.new(nil, nil, nil)

      @log = Utility::Log.new

      @combat_sessions = {}
      @in_combat = false
      @active_combat_session = nil
      @auto_close_combat_session = nil

      @is_spawned = false
      @is_despawned = false
    end

    def storage=(storage)
      @storage = storage
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

    def active_combat_session?
      !@active_combat_session.nil?
    end

    # Return log appropriate to combat context. If in combat, return the combat log. If not in
    # combat, return the normal log.
    def contextual_log
      in_combat? && active_combat_session? ? @active_combat_session.log : @log
    end

    def spawn!(packet, raw_movement_state, raw_values_state)
      to_log!(:Spawn, packet, contextual: false)

      @movement = raw_movement_state
      @values = raw_values_state

      @storage.trigger(:spawn, self)
    end

    def despawn!(packet)
      close_combat_session(:despawn, packet) if in_combat?

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

    # Establish a combat session. Combat sessions are always established on the attacker object,
    # and the victim object gets assigned to the same session. This is true regardless of whether
    # the victim also becomes an attacker.
    def attack_start!(packet)
      open_combat_session(packet) if !(in_combat? && active_combat_session?)

      if in_combat? && active_combat_session?
        if active_combat_session.victim_guid == self.guid
          @auto_close_combat_session = false
        end
      end
    end

    # Finish a combat session and stop logging all events on this object to it.
    def attack_stop!(packet)
      close_combat_session(:attack_stop, packet) if in_combat? && active_combat_session?
    end

    def died!(packet)
      to_log!(:Died, packet)
    end

    def update_values!(updated_values)
      @values.merge!(updated_values)
      @storage.trigger(:update, self)
    end

    def assign_combat_session(combat_session, packet)
      # Don't assign to another combat session since one is currently active.
      return if in_combat? && active_combat_session?

      to_log!(:EnterCombat, packet)

      @in_combat = true

      @active_combat_session = combat_session
      @combat_sessions[@active_combat_session.id] = combat_session
      @auto_close_combat_session = true
    end

    def revoke_combat_session(combat_session, packet)
      return if @auto_close_combat_session == false

      @in_combat = false
      @auto_close_combat_session = true

      if active_combat_session?
        to_log!(:ExitCombat, packet, embed: @active_combat_session.log)
      end

      @active_combat_session = nil
    end

    private def open_combat_session(packet)
      to_log!(:EnterCombat, packet)

      @in_combat = true

      combat_session = Utility::CombatSession.new(self.guid, packet.victim_guid)
      combat_session.open
      @active_combat_session = combat_session
      @combat_sessions[@active_combat_session.id] = combat_session

      # Ensure this is opened on the victim's end, too.
      victim = packet.parser.objects.find_or_create(combat_session.victim_guid)
      victim.assign_combat_session(combat_session, packet)
    end

    private def close_combat_session(reason, packet)
      return if @auto_close_combat_session == false

      @in_combat = false

      if active_combat_session?
        @active_combat_session.close(reason)

        to_log!(:ExitCombat, packet, embed: @active_combat_session.log)

        victim = packet.parser.objects.find_or_create(@active_combat_session.victim_guid)
        victim.revoke_combat_session(@active_combat_session, packet)
      end

      @active_combat_session = nil
    end

    private def to_log!(item_class_name, packet, opts = {})
      item_class = Utility::LogItems.const_get(item_class_name)
      contextual = opts.delete(:contextual) != false
      log_opts = opts

      if contextual && in_combat? && !@active_combat_session.nil?
        combat_context = @active_combat_session.victim?(self.guid) ? :victim : :attacker
        log_opts.merge!(context: combat_context)
      end

      log_item = item_class.new(self, packet, log_opts)

      if contextual
        contextual_log.add(log_item)
      else
        log.add(log_item)
      end
    end

    def method_missing(method_name)
      @values[method_name]
    end
  end
end
