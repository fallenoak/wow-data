module WOW::Capture::Packets
  module Records
    @records = {}

    def self.add(record_name, record)
      @records[record_name] = record
    end

    def self.named(record_name)
      @records[record_name]
    end
  end
end
