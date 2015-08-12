module WOW::Capture::Packets::Readers
  module PetBattle
    def read_pet_battle_pet_update
      pet = {}

      pet[:pet_guid] = read_packed_guid128

      pet[:species_id] = read_int32
      pet[:display_id] = read_int32
      pet[:collar_id] = read_int32

      pet[:level] = read_int16
      pet[:xp] = read_int16

      pet[:current_health] = read_int32
      pet[:max_health] = read_int32
      pet[:power] = read_int32
      pet[:speed] = read_int32
      pet[:npc_team_member_id] = read_int32

      pet[:breed_quality] = read_int16
      pet[:status_flags] = read_int16

      pet[:slot] = read_byte

      abilities_count = read_int32
      auras_count = read_int32
      states_count = read_int32

      abilities = []
      auras = []
      states = []

      abilities_count.times do
        abilities << read_pet_battle_active_ability
      end

      auras_count.times do
        auras << read_pet_battle_active_aura
      end

      states_count.times do
        states << read_pet_battle_active_state
      end

      pet[:active_abilities] = abilities
      pet[:active_auras] = auras
      pet[:active_states] = states

      reset_bit_reader

      custom_name_length = read_bits(7)
      pet[:custom_name] = read_char(custom_name_length)

      pet
    end

    def read_pet_battle_player_update
      player_update = {}

      player_update[:character_guid] = read_packed_guid128

      player_update[:trap_ability_id] = read_int32
      player_update[:trap_status] = read_int32
      player_update[:round_time_secs] = read_int16
      player_update[:front_pet] = read_sbyte
      player_update[:input_flags] = read_byte

      reset_bit_reader

      pets_count = read_bits(2)
      player_update[:pets_count] = pets_count

      pets = []

      pets_count.times do
        pets << read_pet_battle_pet_update
      end

      player_update[:pets] = pets

      player_update
    end

    def read_pet_battle_active_ability
      ability = {}

      ability[:ability_id] = read_int32
      ability[:cooldown_remaining] = read_int16
      ability[:lockdown_remaining] = read_int16
      ability[:ability_index] = read_byte
      ability[:pboid] = read_byte

      ability
    end

    def read_pet_battle_active_aura
      aura = {}

      aura[:ability_id] = read_int32
      aura[:instance_id] = read_int32
      aura[:rounds_remaining] = read_int32
      aura[:current_round] = read_int32
      aura[:caster_pboid] = read_byte

      aura
    end

    def read_pet_battle_active_state
      state = {}

      state[:state_id] = read_int32
      state[:state_value] = read_int32

      state
    end

    def read_pet_battle_enviro_update
      enviro_update = {}

      auras_count = read_int32
      states_count = read_int32

      auras = []
      states = []

      auras_count.times do
        auras << read_pet_battle_active_aura
      end

      states_count.times do
        states << read_pet_battle_active_state
      end

      enviro_update[:active_auras] = auras
      enviro_update[:active_states] = states

      enviro_update
    end

    def read_pet_battle_full_update
      full_update = {}

      player_updates = []

      2.times do
        player_updates << read_pet_battle_player_update
      end

      full_update[:player_updates] = player_updates

      enviro_updates = []

      3.times do
        enviro_updates << read_pet_battle_enviro_update
      end

      full_update[:enviro_updates] = enviro_updates

      full_update[:waiting_for_front_pets_max_secs] = read_int16
      full_update[:pvp_max_round_time] = read_int16

      full_update[:cur_round] = read_int32
      full_update[:npc_creature_id] = read_int32
      full_update[:npc_display_id] = read_int32

      full_update[:cur_pet_battle_state] = read_byte
      full_update[:forfeit_penalty] = read_byte

      full_update[:initial_wild_pet_guid] = read_packed_guid128

      full_update[:is_pvp] = read_bit
      full_update[:can_award_xp] = read_bit

      full_update
    end
  end
end
