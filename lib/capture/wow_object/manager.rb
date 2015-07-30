module WOW::Capture::WOWObject
  class Manager
    def self.build_from_guid(guid)
      object_class = class_for_guid(guid)
      object_class.new(guid)
    end

    def self.class_for_guid(guid)
      case guid.type
      when :creature
        WOW::Capture::WOWObject::Creature
      when :player
        WOW::Capture::WOWObject::Player
      else
        WOW::Capture::WOWObject::Base
      end
    end
  end
end
