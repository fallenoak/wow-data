module WOW
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

      def merge!(other_namespace)
        copied_namespaces = other_namespace.namespaces.clone
        copied_tables = other_namespace.tables.clone

        # Recursively merge namespaces.
        copied_namespaces.each_pair do |copied_namespace_name, copied_namespace|
          if @namespaces.has_key?(copied_namespace_name)
            @namespaces[copied_namespace_name].merge!(copied_namespace)
          else
            @namespaces[copied_namespace_name] = copied_namespace
          end
        end

        # Non-recursively merge tables (ie tables are overwritten).
        @tables.merge!(copied_tables)

        @namespaces.keys.each do |namespace_name|
          define_singleton_method(namespace_name) do
            @namespaces[namespace_name]
          end
        end

        @tables.keys.each do |table_name|
          define_singleton_method(table_name) do
            @tables[table_name]
          end
        end

        self
      end

      def [](path_name)
        @tables[path_name.to_sym] || @namespaces[path_name.to_sym]
      end

      def table(table_name, &definition)
        table = Table.new(self, &definition)

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
      attr_reader :entries, :start_index, :end_index

      def initialize(parent, &definition)
        @parent = parent

        @start_index = nil
        @end_index = nil
        @index_offset = nil

        @entries = {}

        instance_eval(&definition)
      end

      # Table entry
      def e(*definition)
        # Bump the definition's index by index offset if index offset is set.
        definition[0] += @index_offset if !@index_offset.nil?

        entry = Entry.new(*definition)
        @entries[entry.index] = entry

        @start_index = entry.index if @start_index.nil? || @start_index > entry.index
        @end_index = entry.index if @end_index.nil? || @end_index < entry.index
      end

      # Insert other table, and ensure index offset prevents overwriting inserted entries. The
      # other table must reside within the same parent namespace as this table.
      def i(table_name)
        other_table = @parent.send(table_name)

        other_table.entries.each_pair do |other_index, other_entry|
          e(other_entry.index, other_entry.value, other_entry.extras)
        end

        # Set index offset to other table's end index + 1.
        @index_offset = other_table.end_index + 1
      end

      # Extend this table to given index.
      def x(index)
        @end_index = index
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

      def prev(target_index)
        previous_entry = nil

        @entries.each_pair do |index, entry|
          if index >= target_index
            return previous_entry
          else
            previous_entry = entry
          end
        end

        previous_entry
      end

      def find_by_value(value)
        matches = @entries.select { |_, entry| entry.value == value }
        matches[matches.keys.first]
      end

      def find_by_extra(extra_name, extra_value)
        matches = @entries.select { |_, entry| entry.extras[extra_name] == extra_value }
        matches[matches.keys.first]
      end
    end

    class Entry
      attr_reader :index, :value, :extras

      def initialize(index, value, extras = {})
        @index = index

        @value = value
        @value_s = value.to_s.freeze
        @value_h = value.hash

        @extras = extras
      end

      def to_s
        @value_s
      end

      def ==(other)
        other == @value || other.to_s == @value_s
      end
      alias_method :eql?, :==

      def ===(other)
        other === @value || other.to_s === @value_s
      end

      def hash
        @value_h
      end

      def has_extra?(extra)
        @extras.has_key?(extra)
      end

      def inspect
        excluded_variables = [:@value_s, :@value_h]
        all_variables = instance_variables
        variables = all_variables - excluded_variables

        prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

        parts = []

        variables.each do |var|
          parts << "#{var}=#{instance_variable_get(var).inspect}"
        end

        str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

        str
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

    def self.for_build(build_number, opts = {})
      if opts[:merged] == true
        merge_build(build_number)
      else
        @builds[build_number]
      end
    end

    # Traverse all builds from lowest build number to highest, stopping at the given build number.
    # For each build, merge the namespaces together into a merged build, such that the merged build
    # contains the most recent tables for a given namespace 'path'.
    def self.merge_build(build_number)
      source_builds = @builds.keys.select { |bn| bn <= build_number }.sort

      merged_build = Build.new

      source_builds.each do |source_build_number|
        source_build = @builds[source_build_number]
        merged_build.merge!(source_build)
      end

      merged_build
    end
  end
end

# Override String and Symbol equality to support table entries.
class String
  def ==(other)
    if other.is_a?(WOW::Definitions::Entry)
      return other == self
    else
      super(other)
    end
  end

  def ===(other)
    if other.is_a?(WOW::Definitions::Entry)
      return other === self
    else
      super(other)
    end
  end
end

class Symbol
  def ==(other)
    if other.is_a?(WOW::Definitions::Entry)
      return other == self
    else
      super(other)
    end
  end

  def ===(other)
    if other.is_a?(WOW::Definitions::Entry)
      return other === self
    else
      super(other)
    end
  end
end
