module WOW::Capture::WOWObject::Utility
  class Attributes
    class Delta
      class Entry
        attr_reader :attribute_name, :old_value, :new_value, :difference

        def initialize(attribute_name, old_value, new_value)
          @attribute_name = attribute_name

          @old_value = old_value
          @new_value = new_value

          if !@old_value.respond_to?(:-)
            @difference = nil
          else
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

    def initialize(object)
      @object = object
      @attributes = {}
      @object_values = {}
    end

    def object_values
      @object_values
    end

    def set!(given_attributes, mode = :normal)
      given_attributes.each_pair do |attribute_name, object_value|
        @attributes[attribute_name] = object_value.value
        @object_values[attribute_name] = object_value
      end
    end

    def update!(new_attributes)
      delta = Delta.new

      new_attributes.each_pair do |attribute_name, object_value|
        old_value = @attributes[attribute_name]
        new_value = object_value.value

        next if new_value == old_value

        delta.add!(attribute_name, old_value, new_value)

        @attributes[attribute_name] = new_value
        @object_values[attribute_name] = object_value
      end

      delta
    end

    def each_pair(&block)
      @attributes.each_pair.each do |key, value|
        block.call(key, value)
      end
    end

    def method_missing(method_name)
      if @attributes.has_key?(method_name)
        @attributes[method_name.to_sym]
      else
        nil
      end
    end
  end
end
