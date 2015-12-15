module WOW::Capture::Packets::SMSG
  class LoginVerifyWorld < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        int32     :map_id
        coord     :position,        format: :xyzo
        uint32    :reason
      end
    end

    def update_state!
      #parser.session.map_change!(@map_id)
    end
  end
end
