module WOW::Capture::Packets::SMSG
  class OnMonsterMove < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        guid128     :guid,      packed: true
        coord       :position,  format: :xyz
      end
    end

    private def track_references!
      if record.guid.creature?
        add_reference!('Mover', :mover, :creature, record.guid.entry_id)
      end
    end

    private def update_state!
      wow_object = parser.objects.find_or_create(record.guid)
      wow_object.move!(self)
    end
  end
end
