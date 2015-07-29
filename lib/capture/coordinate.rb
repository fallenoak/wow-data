module WOW::Capture
  class Coordinate
    attr_reader :x, :y, :z

    def initialize(*coord)
      if coord.length == 1
        @x, @y, @z = coord[0]
      else
        @x, @y, @z = coord
      end
    end

    def inspect
      output = ''

      output << "#<#{self.class}:0x#{self.__id__.to_s(16)}"
      output << " X: #{'%9.3f' % @x}; Y: #{'%10.3f' % @y}; Z: #{ '%8.3f' % @z}"
      output << ">"

      output
    end
  end
end
