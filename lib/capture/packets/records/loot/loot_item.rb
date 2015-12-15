module WOW::Capture::Packets::Records
  class LootItem < WOW::Capture::Packets::Records::Base
    structure do
      reset_bit_reader

      bits      :item_type,               length: 2
      bits      :item_ui_type,            length: 3
      bit       :can_trade_to_tap_list
      uint32    :quantity
      uint8     :loot_item_type
      uint8     :loot_list_id

      struct    :item_instance,           source: :item_instance
    end
  end
end
