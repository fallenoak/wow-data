module WOW::Capture::Packets::Records
  class SpellMissStatus < WOW::Capture::Packets::Records::Base
    structure do
      reset_bit_reader

      bits      :reason,          length: 4
      bits      :reflect_status,  if: proc { reason == 11 }
    end
  end
end
