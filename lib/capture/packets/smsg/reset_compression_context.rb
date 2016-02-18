module WOW::Capture::Packets::SMSG
  class ResetCompressionContext < WOW::Capture::Packets::Base
    structure do
      uint32    :unknown_1
    end

    def update_state!
      parser.zmanager.reset_context(header.connection_index)
    end
  end
end
