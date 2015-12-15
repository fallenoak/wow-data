module WOW::Capture::Packets::SMSG
  class QueryCreatureResponse < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        uint32    :entry_id,            mask: 0x7FFFFFFF

        bit       :has_data

        halt      if: proc { has_data != true }

        reset_bit_reader

        bits      :has_title,           length: 11
        bits      :has_female_title,    length: 11
        bits      :has_cursor_name,     length: 6

        bit       :racial_leader

        iarray    [:name_lengths, :female_name_lengths], length: 4 do
                    bits length: 11
                    bits length: 11
                  end

        iarray    [:names, :female_names], length: 4 do |index|
                    string if: proc { name_lengths[index] > 1 }
                    string if: proc { female_name_lengths[index] > 1 }
                  end

        uint32    :flags_1
        uint32    :flags_2

        int32     :creature_type_id
        int32     :creature_family_id
        int32     :creature_rank,       remap: :creature_ranks

        array     :creature_kill_credit_ids, length: 2 do
                    uint32
                  end

        array     :creature_display_ids, length: 4 do
                    uint32
                  end

        float     :health_multiplier
        float     :power_multiplier

        int32     :quest_item_ids_length

        uint32    :creature_movement_info_id

        int32     :expansion

        int32     :quest_flags

        string    :title,               if: proc { has_title > 1 }
        string    :female_title,        if: proc { has_female_title > 1 }
        string    :cursor_name,         if: proc { has_cursor_name > 1 }

        array     :quest_item_ids,      length: proc { quest_item_ids_length } do
                    int32
                  end
      end
    end

    def has_data?
      record.has_data == true
    end

    def racial_leader?
      record.racial_leader == true
    end

    def track_references!
      add_reference!('Creature', :creature, :creature, record.entry_id)
    end

    def update_state!
    end
  end
end
