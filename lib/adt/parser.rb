require 'stringio'

module WOW::ADT
  class Parser
    def initialize(path, opts = {})
      @file = File.open(path, 'rb')

      @filename = path.split('/').last

      @records = []

      read_records

      close
    end

    def close
      @file.close
    end

    def eof?
      @file.eof?
    end

    def records(type = nil)
      if type.nil?
        @records
      else
        record_class = WOW::ADT::Records.const_get(type.upcase)
        @records.select { |r| r.is_a?(record_class) }
      end
    end

    private def read_records
      while !eof?
        record_type = read_type
        record_length = read_uint32
        record_data = read_data(record_length)

        record = Records.const_get(record_type).new(record_data)

        @records << record
      end
    end

    private def read_type
      @file.read(4).reverse
    end

    private def read_uint32
      @file.read(4).unpack('V').first
    end

    private def read_data(length)
      @file.read(length)
    end
  end
end
