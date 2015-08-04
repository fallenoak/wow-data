module WOW::Capture::WOWObject::Utility
  class Attributes
    class Delta
      class Entry
        attr_reader :attribute_name, :old_value, :new_value, :difference

        def initialize(attribute_name, old_value, new_value)
          @attribute_name = attribute_name

          @old_value = old_value
          @new_value = new_value

          if @old_value.nil? && !@new_value.nil?
            @difference = @new_value
          elsif !@old_value.nil? && @new_value.nil?
            @difference = -@old_value
          elsif !@old_value.nil? && !@new_value.nil?
            @difference = @new_value - @old_value
          else
            @difference = nil
          end
        end
      end

      def initialize
        @delta = {}
      end

      def count
        @delta.keys.length
      end

      def add!(attribute_name, old_value, new_value)
        @delta[attribute_name.to_sym] = Entry.new(attribute_name, old_value, new_value)
      end

      def each(&block)
        @delta.keys.each do |key|
          block.call(@delta[key])
        end
      end

      def method_missing(method_name)
        @delta[method_name.to_sym]
      end
    end

    def initialize(object, attributes = {})
      @attributes = attributes
    end

    def set!(initial_attributes)
      @attributes = initial_attributes
    end

    def update!(new_attributes)
      delta = Delta.new

      new_attributes.each_pair do |attribute_name, attribute_value|
        delta.add!(attribute_name, @attributes[attribute_name], attribute_value)
        @attributes[attribute_name] = attribute_value
      end

      delta
    end

    def method_missing(method_name)
      @attributes[method_name.to_sym]
    end
  end
end
