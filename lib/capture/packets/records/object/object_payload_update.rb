module WOW::Capture::Packets::Records
  class ObjectPayloadUpdate < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :guid,              packed: true

      objvals   :values,            object_type: proc { guid.object_type }
    end
  end
end
