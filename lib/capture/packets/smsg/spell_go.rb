module WOW::Capture::Packets::SMSG
  class SpellGo < WOW::Capture::Packets::Base
    include WOW::Capture::Packets::Readers::Spell

    attr_reader :caster_guid, :caster_unit_guid, :cast_id, :spell_id, :spell_target

    def parse!
      read_spell_cast_data
    end

    def update_state!
      caster = parser.objects.find_or_create(@caster_guid)
      caster.spell_go!(self)
    end
  end
end
