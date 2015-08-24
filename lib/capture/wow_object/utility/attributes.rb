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

    def initialize(object, attributes = {})
      @object = object
      @attributes = attributes
    end

    def set!(given_attributes, mode = :normal)
      given_attributes.each_pair do |attribute_name, attribute_data|
        type = attribute_data[:type]
        size = attribute_data[:size]

        if mode == :zeroed
          blocks = Array.new(size, 0)
        else
          blocks = attribute_data[:blocks].map { |block| block[:value] }
        end

        update_value = WOW::Capture::UpdateValue.new(@object.parser, type, size, blocks)

        @attributes[attribute_name] = update_value
      end
    end

    def update!(new_attributes)
      delta = Delta.new

      new_attributes.each_pair do |attribute_name, attribute_data|
        if !@attributes.has_key?(attribute_name)
          set!({ attribute_name => attribute_data }, :zeroed)
        end

        update_value = @attributes[attribute_name]

        old_value = update_value.value

        attribute_data[:blocks].each do |block|
          update_value[block[:offset]] = block[:value]
        end

        new_value = update_value.value

        delta.add!(attribute_name, old_value, new_value)
      end

      delta
    end

    def each_pair(&block)
      @attributes.each_pair.each do |key, value|
        block.call(key, value.value)
      end
    end

    def method_missing(method_name)
      if @attributes.has_key?(method_name)
        @attributes[method_name.to_sym].value
      else
        nil
      end
    end
  end
end
