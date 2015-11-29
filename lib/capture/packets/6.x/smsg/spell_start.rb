module WOW::Capture::Packets::SMSG
  class SpellStart < WOW::Capture::Packets::Base
    include WOW::Capture::Packets::Readers::Spell

    attr_reader :caster_guid, :caster_unit_guid, :cast_id, :spell_id, :spell_target

    def parse!
      read_spell_cast_data
    end

    def track_references!
      if @caster_guid.creature?
        add_reference!('Caster', :caster, :creature, @caster_guid.entry_id)
      end

      add_reference!('Spell', :spell, :spell, @spell_id)
    end

    def update_state!
      caster = parser.objects.find_or_create(@caster_guid)
      caster.spell_start!(self)
    end
  end
end
