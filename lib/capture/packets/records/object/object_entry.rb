module WOW::Capture::Packets::Records
  class ObjectEntry < WOW::Capture::Packets::Records::Base
    structure do
      uint8   :entry_type,  remap:    :object_entry_types

      struct  :payload,     if:       proc { entry_type == :update },
                            source:   :object_payload_update

      struct  :payload,     if:       proc { entry_type == :create1 },
                            source:   :object_payload_create1

      struct  :payload,     if:       proc { entry_type == :create2 },
                            source:   :object_payload_create2

      struct  :payload,     if:       proc { entry_type == :destroy },
                            source:   :object_payload_create1
    end
  end
end
