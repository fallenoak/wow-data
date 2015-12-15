module WOW::Capture::Packets::Records
  class LootCurrency < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :id
      uint32    :quantity
      uint8     :loot_list_id

      reset_bit_reader

      bits      :ui_type,         length: 3
    end
  end
end
