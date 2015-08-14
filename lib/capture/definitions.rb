module WOW::Capture
  module Definitions
    class Namespace
      attr_reader :tables, :namespaces

      def initialize
        @tables = {}
        @namespaces = {}
      end

      def define!(&definition)
        instance_eval(&definition)
      end

      def [](path_name)
        @tables[path_name.to_sym] || @namespaces[path_name.to_sym]
      end

      def table(table_name, &definition)
        table = Table.new(&definition)

        @tables[table_name] = table

        define_singleton_method(table_name) do
          table
        end
      end

      def namespace(namespace_name, &definition)
        if @namespaces.has_key?(namespace_name)
          namespace = @namespaces[namespace_name]
          namespace.define!(&definition)
        else
          namespace = Namespace.new
          namespace.define!(&definition)
          @namespaces[namespace_name] = namespace
        end

        if !respond_to?(namespace_name)
          define_singleton_method(namespace_name) do
            namespace
          end
        end
      end
    end

    class Build < Namespace
    end

    class Table
      attr_reader :entries

      def initialize(&definition)
        @entries = {}
        instance_eval(&definition)
      end

      def e(*definition)
        entry = Entry.new(*definition)
        @entries[entry.index] = entry
      end

      def each(&block)
        @entries.each_pair do |index, entry|
          block.call(entry)
        end
      end

      def find(index)
        @entries[index]
      end
      alias_method :[], :find

      def find_by_value(value)
        @entries.select { |entry| entry.value == value }.first
      end

      def find_by_extra(extra_name, extra_value)
        @entries.select { |entry| entry.extras[extra_name] == extra_value }.first
      end
    end

    class Entry
      attr_reader :index, :value, :extras

      def initialize(index, value, extras = {})
        @index = index
        @value = value
        @extras = extras
      end

      def to_s
        @value.to_s
      end

      def ==(other)
        other == @value || other.to_s == @value.to_s
      end
      alias_method :eql?, :==

      def ===(other)
        other === @value || other.to_s === @value.to_s
      end

      def hash
        @value.hash
      end

      private def to_ary
        nil
      end

      def method_missing(extra)
        if @extras.has_key?(extra.to_sym)
          return @extras[extra.to_sym]
        else
          raise "Unknown attribute! #{extra}"
        end
      end
    end

    @builds = {}

    def self.build(build_number, &definition)
      if @builds.has_key?(build_number)
        build = @builds[build_number]
        build.define!(&definition)
      else
        build = Build.new
        build.define!(&definition)
        @builds[build_number] = build
      end
    end

    def self.for_build(build_number)
      @builds[build_number]
    end
  end
end

# Override String and Symbol equality to support table entries.
class String
  def ==(other)
    if other.is_a?(WOW::Capture::Definitions::Entry)
      return other == self
    else
      super(other)
    end
  end

  def ===(other)
    if other.is_a?(WOW::Capture::Definitions::Entry)
      return other === self
    else
      super(other)
    end
  end
end

class Symbol
  def ==(other)
    if other.is_a?(WOW::Capture::Definitions::Entry)
      return other == self
    else
      super(other)
    end
  end

  def ===(other)
    if other.is_a?(WOW::Capture::Definitions::Entry)
      return other === self
    else
      super(other)
    end
  end
end
