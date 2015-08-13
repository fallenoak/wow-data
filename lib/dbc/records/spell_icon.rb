module WOW::DBC::Records
  class SpellIcon < WOW::DBC::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:string, :icon_path]
    ]
  end
end
