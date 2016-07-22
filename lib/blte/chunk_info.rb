module WOW::BLTE
  class ChunkInfo
    attr_accessor :flags, :chunk_count, :entries, :decoded_size

    def initialize
      @flags = nil
      @chunk_count = 0
      @entries = []
    end
  end
end
