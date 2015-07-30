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
      output << " @x= #{@x ? '%10.3f' % @x : '%10s' % '---'}"
      output << " @y= #{@y ? '%10.3f' % @y : '%10s' % '---' }"
      output << " @z= #{@z ? '%8.3f' % @z : '%8s' % '---' }"
      output << ">"

      output
    end

    def pretty_print
      output = ''

      output << "{coord"
      output << " x: #{@x ? '%10.3f' % @x : '%10s' % '---'}"
      output << "; y: #{@y ? '%10.3f' % @y : '%10s' % '---'}"
      output << "; z: #{@z ? '%8.3f' % @z : '%8s' % '---'}"
      output << "}"

      output
    end
  end
end
