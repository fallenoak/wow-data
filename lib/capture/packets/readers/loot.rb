module WOW::Capture::Packets::Readers
  module Loot
    def read_loot_item
      item = {}

      reset_bit_reader

      item[:item_type] = read_bits(2)
      item[:item_ui_type] = read_bits(3)
      item[:can_trade_to_tap_list] = read_bit
      item[:quantity] = read_uint32
      item[:loot_item_type] = read_byte
      item[:loot_list_id] = read_byte

      item[:instance] = read_item_instance

      item
    end

    def read_loot_currency
      currency = {}

      currency[:id] = read_uint32
      currency[:quantity] = read_uint32
      currency[:loot_list_id] = read_byte

      reset_bit_reader

      currency[:ui_type] = read_bits(3)

      currency
    end
  end
end
