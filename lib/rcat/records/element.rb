module WOW::RCAT
  class Element < BinData::Record
    endian      :little

    ofs_strz    :name
    ofs_strz    :data
  end
end
