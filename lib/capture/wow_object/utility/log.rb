module WOW::Capture::WOWObject::Utility
  class Log
    attr_reader :items

    def initialize
      @items = []
    end

    def items_by_type(*types)
      @items.select { |i| types.include?(i.type) }
    end

    def add(item)
      @items << item
    end

    def <<(item)
      add(item)
    end
  end
end
