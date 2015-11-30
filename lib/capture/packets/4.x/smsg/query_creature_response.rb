module WOW::Capture::Packets::SMSG
  class QueryCreatureResponse < WOW::Capture::Packets::Base
    attr_reader :entry_id, :name, :female_name, :flags_1, :flags_2, :creature_type_id,
      :creature_family_id, :creature_rank, :creature_kill_credit_ids, :creature_display_ids,
      :health_multiplier, :power_multiplier, :creature_movement_info_id, :expansion, :quest_flags,
      :title, :female_title, :cursor_name, :quest_item_ids

    def parse!
      raw_entry_id = read_uint32
      @entry_id = raw_entry_id & 0x7FFFFFFF

      @name = nil
      @female_name = nil

      names = []
      female_names = []

      4.times do
        names << read_string
      end

      @name = names[0]

      if client_build >= 13914
        4.times do
          female_names << read_string
        end

        @female_name = female_names[0]
      end

      @title = read_string

      @cursor_name = read_string

      @flags_1 = read_uint32

      if client_build >= 13914 # unknown if earlier or later
        @flags_2 = read_uint32
      end

      @creature_type_id = read_int32
      @creature_family_id = read_int32

      creature_rank_index = read_int32
      @creature_rank = parser.defs.creature_ranks[creature_rank_index]

      @creature_kill_credit_ids = []

      2.times do
        @creature_kill_credit_ids << read_uint32
      end

      @creature_display_ids = []

      4.times do
        @creature_display_ids << read_uint32
      end

      @health_multiplier = read_float
      @power_multiplier = read_float

      @racial_leader = read_bool

      quest_items_count = 6

      @quest_item_ids = []

      quest_items_count.times do
        @quest_item_ids << read_int32
      end

      @creature_movement_info_id = read_uint32

      @expansion = nil

      if client_build >= 13164
        expansion_index = read_uint32
        @expansion = parser.defs.expansions[expansion_index]
      end
    end

    def racial_leader?
      @racial_leader == true
    end

    def track_references!
      add_reference!('Creature', :creature, :creature, @entry_id)
    end

    def update_state!
    end
  end
end
