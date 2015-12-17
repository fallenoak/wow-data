module WOW::Capture::WOWObject
  class Base
    attr_reader :guid, :map_id, :session_map_id, :type, :log, :positions, :movement, :attributes,
      :current_position, :active_combat_sessions

    def initialize(guid)
      @guid = guid
      @type = guid.type
      @object_type = guid.object_type

      @map_id = @guid.map_id
      @session_map_id = @map_id

      @current_position = WOW::Capture::Types::Coordinate.new(nil, nil, nil, nil)
      @positions = []

      @log = Utility::Log.new

      @in_combat = false

      @is_created = false
      @is_destroyed = false

      @attributes = Utility::Attributes.new(self)
    end

    def storage=(storage)
      @storage = storage
    end

    def parser
      @storage.parser
    end

    def created?
      @is_created == true
    end

    def destroyed?
      @is_created == false
    end

    def in_combat?
      @in_combat == true
    end

    def create_object!(packet, raw_movement_state, values)
      to_log!(:CreateObject, packet, contextual: false)

      @movement = raw_movement_state
      @attributes.set!(values)

      if !@movement.nil? && !@movement.update.nil? && !@movement.update.status.nil?
        status_position = @movement.update.status.position

        if !status_position.nil?
          @current_position = status_position
          @positions << status_position
        end
      end

      @is_created = true
      @is_destroyed = false

      @session_map_id = packet.parser.session.current_map_id

      @storage.trigger(:object_created, self)
    end

    def destroy_object!(packet)
      related_combat_sessions(:attacker).each do |combat_session|
        combat_session.remove_attacker(self)
      end

      related_combat_sessions(:victim).each do |combat_session|
        combat_session.remove_victim(self)
      end

      @is_created = false
      @is_destroyed = true

      to_log!(:DestroyObject, packet, contextual: false)

      @storage.trigger(:object_destroyed, self)
    end

    def loot_response!(packet)
      to_log!(:LootResponse, packet)
    end

    def move!(packet)
      to_log!(:Move, packet)

      @current_position = packet.record.position
      @positions << packet.record.position

      @storage.trigger(:moved, self)
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
      attacker = parser.objects.find_or_create(packet.record.attacker_guid)
      victim = parser.objects.find_or_create(packet.record.victim_guid)

      relevant_session = parser.combat_sessions.find_by_active_participants(attacker, victim).first
      relevant_session = parser.combat_sessions.create if relevant_session.nil?

      relevant_session.add_attacker(attacker)
      relevant_session.add_victim(victim)

      to_log!(:AttackStart, packet)
    end

    def attack_stop!(packet)
      attacker = parser.objects.find_or_create(packet.record.attacker_guid)
      victim = parser.objects.find_or_create(packet.record.victim_guid)

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

    def update_attributes!(packet, new_attributes)
      delta = @attributes.update!(new_attributes)

      to_log!(:Update, packet, delta: delta)

      @storage.trigger(:update, self)
    end

    def spell_start!(packet)
      to_log!(:SpellStart, packet)
    end

    def spell_go!(packet)
      to_log!(:SpellGo, packet)
    end

    def inspect
      excluded_variables = [:@storage]
      all_variables = instance_variables
      variables = all_variables - excluded_variables

      prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

      parts = []

      variables.each do |var|
        parts << "#{var}=#{instance_variable_get(var).inspect}"
      end

      str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

      str
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
      contextual = opts.delete(:contextual) != false

      # Standard logging.
      item_class = Utility::LogItems.const_get(item_class_name)
      log_item = item_class.new(self, packet, opts)
      log.add(log_item)

      return if !contextual

      # Contextual logging.
      related_combat_sessions.each do |combat_session|
        combat_session.log.add(log_item)
      end
    end
  end
end
