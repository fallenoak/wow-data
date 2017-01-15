module WOW::RCAT
  class File < BinData::Record
    endian  :little

    string  :token, length: 4

    uint32  :unk_0
    uint32  :unk_1

    uint32  :meta_count

    array   :meta, initial_length: :meta_count do
              element
            end

    uint32  :group_count

    array   :groups, initial_length: :group_count do
              group
            end
  end
end
