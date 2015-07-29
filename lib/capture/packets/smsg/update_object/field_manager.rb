module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module FieldManager
      def self.field_name_at_index(object_type, field_index)
        field_modules = field_modules_for(object_type)
        field_module = select_field_module(field_modules, field_index)

        field_module.nil? ? nil : find_field_name(field_module, field_index)
      end

      def self.field_modules_for(object_type)
        case object_type
        when :unit
          [Fields::ObjectFields, Fields::UnitFields]
        when :player
          [Fields::ObjectFields, Fields::UnitFields, Fields::PlayerFields]
        when :item
          [Fields::ObjectFields, Fields::ItemFields]
        else
          [nil]
        end
      end

      def self.select_field_module(field_modules, field_index)
        return nil if field_modules.length == 1 && field_modules[0].nil?

        field_modules.each do |field_module|
          return field_module if field_index >= field_module::BASELINE && field_index < field_module::BOUNDARY
        end

        nil
      end

      def self.find_field_name(field_module, field_index)
        last_field_name = nil
        last_field_diff = 0

        (field_module::BASELINE...field_module::BOUNDARY).each do |definition_index|
          if field_module::DEFINITIONS[definition_index].nil?
            last_field_diff += 1
          else
            last_field_name = field_module::DEFINITIONS[definition_index]
            last_field_diff = 1
          end

          if definition_index == field_index
            if last_field_name.nil?
              return nil
            elsif last_field_diff < 2
              return last_field_name
            else
              return (last_field_name.to_s << '_' << last_field_diff.to_s).to_sym
            end
          end
        end
      end
    end
  end
end
