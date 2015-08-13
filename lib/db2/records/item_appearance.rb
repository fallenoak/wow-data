module WOW::DB2::Records
  class ItemAppearance < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :item_display_id],
      [:uint32, :icon_file_data_id]
    ]
  end
end
