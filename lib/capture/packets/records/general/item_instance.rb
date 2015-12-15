module WOW::Capture::Packets::Records
  class ItemInstance < WOW::Capture::Packets::Records::Base
    structure do
      int32     :item_id
      uint32    :random_properties_seed
      uint32    :random_properties_id

      reset_bit_reader

      bit       :has_bonuses
      bit       :has_modifications

      struct    :bonuses,                 if: proc { has_bonuses } do
        uint8   :context
        uint32  :bonuses_length
        array   :bonus_ids,               length: proc { bonuses.bonuses_length } do
                  uint32
                end
      end

      struct    :modifications,           if: proc { has_modifications } do
        uint32  :mask
      end
    end
  end
end
