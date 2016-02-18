module WOW::Capture::Packets::SMSG
  class UpdateAccountData < WOW::Capture::Packets::Base
    structure do
      build 0..15595 do
        guid64    :guid

        int32     :data_type

        time      :login_time

        int32     :inflated_length

        inflate   :payload,           inflated_length: proc { inflated_length },
                                      preserve_context: false
      end
    end
  end
end
