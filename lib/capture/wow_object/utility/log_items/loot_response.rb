module WOW::Capture::WOWObject::Utility::LogItems
  class LootResponse < Base
    attr_reader :coins, :items, :currencies

    def type
      :loot_response
    end

    def parse!
      @coins = packet.record.coins
      @items = packet.record.items
      @currencies = packet.record.currencies
    end

    def pretty_print
      output = ''

      output << pretty_prefix
      output << " Coins:      #{@coins}"

      if @items.empty?
        output << pretty_line
        output << " Items:      None"
      else
        @items.each do |item|
          output << pretty_line
          output << " Item:       #{item.quantity}x ##{item.item_instance.item_id}"
        end
      end

      if @currencies.empty?
        output << pretty_line
        output << " Currencies: None"
      else
        @currencies.each do |currency|
          output << pretty_line
          output << " Currency:   #{currency.inspect}"
        end
      end

      output
    end
  end
end
