module WOW::DB2::Records
  class Item < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :item_class],
      [:uint32, :item_subclass],
      [:int32,  :sound_override_subclass],
      [:int32,  :material],
      [:uint32, :inventory_type],
      [:uint32, :sheath],
      [:uint32, :icon_file_data_id],
      [:uint32, :group_sounds_id]
    ]
  end
end
