module WOW::Capture::Packets::Records
  class SpellRunes < WOW::Capture::Packets::Records::Base
    structure do
      uint8     :start
      uint8     :count

      reset_bit_reader

      bits      :cooldowns_length,      length: 3

      array     :cooldowns,             length: proc { cooldowns_length } do
                  uint8
                end
    end
  end
end
