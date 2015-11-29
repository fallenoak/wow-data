module WOW::Capture::Packets::SMSG
  class LootResponse < WOW::Capture::Packets::Base
    include WOW::Capture::Packets::Readers::Item
    include WOW::Capture::Packets::Readers::Loot

    attr_reader :owner_guid, :loot_object_guid, :failure_reason, :acquire_reason, :loot_method,
      :threshold, :coins, :items, :currencies, :acquired, :personal_looting, :ae_looting

    def parse!
      @owner_guid = read_packed_guid128
      @loot_object_guid = read_packed_guid128

      @failure_reason = read_byte
      @acquire_reason = read_byte
      @loot_method = read_byte
      @threshold = read_byte

      @coins = read_uint32

      items_count = read_uint32
      currencies_count = read_uint32

      @items = []
      @currencies = []

      items_count.times do
        @items << read_loot_item
      end

      currencies_count.times do
        @currency << read_loot_currency
      end

      reset_bit_reader

      @acquired = read_bit
      @personal_looting = read_bit
      @ae_looting = read_bit
    end

    def acquired?
      @acquired == true
    end

    def personal_looting?
      @personal_looting == true
    end

    def ae_looting?
      @ae_looting == true
    end

    private def track_references!
      if @owner_guid.creature?
        add_reference!('Owner', :owner, :creature, @owner_guid.entry_id)
      end

      @items.each do |item|
        entry_id = item[:instance][:item_id]
        add_reference!('Loot', :item, :item, entry_id)
      end
    end

    private def update_state!
      owner = parser.objects.find_or_create(@owner_guid)
      owner.loot_response!(self)
    end
  end
end
