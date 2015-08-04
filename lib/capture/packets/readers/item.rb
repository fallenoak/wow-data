module WOW::Capture::Packets::Readers
  module Item
    def read_item_instance
      instance = {}

      instance[:item_id] = read_int32
      instance[:random_properties_seed] = read_uint32
      instance[:random_properties_id] = read_uint32

      reset_bit_reader

      has_bonuses = read_bit
      has_modifications = read_bit

      if has_bonuses
        bonuses = {}

        bonuses[:context] = read_byte
        bonuses[:bonus_list_ids] = []

        bonus_count = read_uint32

        bonus_count.times do
          bonuses[:bonus_list_ids] << read_uint32
        end

        instance[:bonuses] = bonuses
      end

      if has_modifications
        mask = read_uint32
      end

      instance
    end
  end
end
