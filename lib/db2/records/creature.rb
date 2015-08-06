module WOW::DB2::Records
  class Creature < WOW::DB2::Records::Base
    STRUCTURE = [
      [:uint32, :id],
      [:uint32, :unk1],
      [:uint32, :unk2],
      [:uint32, :unk3],
      [:uint32, :unk4],
      [:uint32, :unk5],
      [:uint32, :unk6],
      [:uint32, :unk7],
      [:uint32, :unk8],
      [:uint32, :unk9],
      [:uint32, :unk10],
      [:uint32, :unk11],
      [:uint32, :unk12],
      [:uint32, :unk13],
      [:string, :name],
      [:uint32, :unk14],
      [:uint32, :unk15],
      [:uint32, :unk16],
      [:uint32, :unk17],
      [:uint32, :unk18]
    ]
  end
end
