module WOW::Capture::Packets::Records
  class ObjectPayloadCreate2 < WOW::Capture::Packets::Records::Base
    structure do
      guid128   :guid,              packed: true

      uint8     :object_type,       remap: :object_types

      struct    :movement_state,    source: :movement_state

      objvals   :values,            object_guid: proc { guid }, object_type: proc { object_type }
    end
  end
end
