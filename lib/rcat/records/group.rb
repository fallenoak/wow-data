module WOW::RCAT
  class Group < BinData::Record
    endian      :little

    ofs_strz    :label

    uint32      :element_count

    array       :elements, initial_length: :element_count do
                  element
                end
  end
end
