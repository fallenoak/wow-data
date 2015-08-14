module WOW::Capture::Packets::SMSG
  class QueryCreatureResponse < WOW::Capture::Packets::Base
    attr_reader :entry_id, :name, :female_name, :flags_1, :flags_2, :creature_type_id,
      :creature_family_id, :creature_rank, :creature_kill_credit_ids, :creature_display_ids,
      :health_multiplier, :power_multiplier, :creature_movement_info_id, :required_expansion,
      :quest_flags, :title, :alternate_title, :cursor_name, :quest_item_ids

    def parse!
      raw_entry_id = read_uint32
      @entry_id = raw_entry_id & 0x7FFFFFFF

      @has_data = read_bit
      return if !has_data?

      reset_bit_reader

      has_title = read_bits(11) > 1
      has_alternate_title = read_bits(11) > 1
      has_cursor_name = read_bits(6) > 1

      @racial_leader = read_bit

      @name = nil
      @female_name = nil

      name_lengths = []
      alternate_name_lengths = []

      4.times do
        name_lengths << read_bits(11)
        alternate_name_lengths << read_bits(11)
      end

      (0...4).each do |i|
        @name = read_string if name_lengths[i] > 1
        @female_name = read_string if alternate_name_lengths[i] > 1
      end

      @flags_1 = read_uint32
      @flags_2 = read_uint32

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

      quest_items_count = read_int32

      @creature_movement_info_id = read_uint32

      required_expansion_index = read_int32
      @required_expansion = parser.defs.expansions[required_expansion_index]

      @quest_flags = read_int32

      @title = nil
      @alternate_title = nil
      @cursor_name = nil

      if has_title
        @title = read_string
      end

      if has_alternate_title
        @alternate_title = read_string
      end

      if has_cursor_name
        @cursor_name = read_string
      end

      @quest_item_ids = []

      quest_items_count.times do
        @quest_item_ids << read_int32
      end
    end

    def has_data?
      @has_data == true
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
