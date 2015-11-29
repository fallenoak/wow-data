module WOW::Capture::Packets::SMSG
  class UpdateObject < WOW::Capture::Packets::Base
    module EntryTypes
      VALUES          = 0
      CREATE_OBJECT_1 = 1
      CREATE_OBJECT_2 = 2
      DESTROY_OBJECTS = 3
    end
  end
end
