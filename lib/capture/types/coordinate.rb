module WOW::Capture::Types
  class Coordinate
    attr_reader :x, :y, :z, :o

    def initialize(*coord)
      if coord.length == 1
        @x, @y, @z, @o = coord[0]
      else
        @x, @y, @z, @o = coord
      end
    end

    def inspect
      output = ''

      output << "#<#{self.class}:0x#{self.__id__.to_s(16)}"
      output << " @x= #{@x ? '%10.3f' % @x : '%10s' % '---'}"
      output << " @y= #{@y ? '%10.3f' % @y : '%10s' % '---' }"
      output << " @z= #{@z ? '%8.3f' % @z : '%8s' % '---' }"
      output << " @o= #{@o ? '%8.3f' % @o : '%8s' % '---' }" if !@o.nil?
      output << ">"

      output
    end

    def pretty_print(opts = {})
      output = ''

      output << "{coord"
      output << " x: #{@x ? '%10.3f' % @x : '%10s' % '---'}"
      output << "; y: #{@y ? '%10.3f' % @y : '%10s' % '---'}"
      output << "; z: #{@z ? '%8.3f' % @z : '%8s' % '---'}"
      output << "; o: #{@o ? '%8.3f' % @o : '%8s' % '---'}" if !@o.nil?
      output << "}"

      output
    end

    def to_h
      if o.nil?
        {
          x: x,
          y: y,
          z: z
        }
      else
        {
          x: x,
          y: y,
          z: z,
          o: o
        }
      end
    end
  end
end
