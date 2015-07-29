module WOW::Capture::WOWObject::Utility
  class Log
    attr_reader :items

    def initialize
      @items = []
    end

    def items_by_type(type)
      @items.select { |i| i.type == type }
    end

    def add(item)
      @items << item
    end

    def <<(item)
      add(item)
    end
  end
end
