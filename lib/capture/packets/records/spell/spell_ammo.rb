module WOW::Capture::Packets::Records
  class SpellAmmo < WOW::Capture::Packets::Records::Base
    structure do
      uint32    :display_id
      uint8     :inventory_type
    end
  end
end
