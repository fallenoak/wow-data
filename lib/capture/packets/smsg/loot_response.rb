module WOW::Capture::Packets::SMSG
  class LootResponse < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128   :owner_guid,          packed: true
        guid128   :loot_object_guid,    packed: true

        uint8     :failure_reason
        uint8     :acquire_reason
        uint8     :loot_method
        uint8     :threshold

        uint32    :coins

        uint32    :items_length
        uint32    :currencies_length

        array     :items,               length: proc { items_length } do
                    struct source: :loot_item
                  end

        array     :currencies,          length: proc { currencies_length } do
                    struct source: :loot_currency
                  end

        reset_bit_reader

        bit       :acquired
        bit       :personal_looting
        bit       :ae_looting
      end
    end

    private def track_references!
      if record.owner_guid.creature?
        add_reference!('Owner', :owner, :creature, record.owner_guid.entry_id)
      end

      record.items.each do |item|
        entry_id = item.item_instance.item_id
        add_reference!('Loot', :item, :item, entry_id)
      end
    end

    private def update_state!
      owner = parser.objects.find_or_create(record.owner_guid)
      owner.loot_response!(self)
    end
  end
end
