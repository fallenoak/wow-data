module WOW::RCAT
  class OfsStrz < BinData::BasePrimitive
    def read_and_return_value(io)
      offset = BinData::Uint32le.read(io)

      # Delayed IO presents difficulties, so we grab the underlying IO object to manipulate pos
      raw_io = io.instance_variable_get(:@raw_io)

      pos = raw_io.pos

      raw_io.pos = offset

      str = BinData::Stringz.new.read(io).to_s

      raw_io.pos = pos

      # Ends with a null byte
      str.chomp!("\x00")

      str
    end

    def sensible_default
      ''
    end
  end
end
