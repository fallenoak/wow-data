module WOW::Capture::Packets::SMSG
  class SpellStart < WOW::Capture::Packets::Base
    structure do
      build 0...16981 do
        struct  :spell_cast,   source: :spell_cast
      end

      build 19033 do
        struct  :spell_cast,   source: :spell_cast
      end
    end

    def track_references!
      if record.spell_cast.caster_guid.creature?
        add_reference!('Caster', :caster, :creature, record.spell_cast.caster_guid.entry_id)
      end

      add_reference!('Spell', :spell, :spell, record.spell_cast.spell_id)
    end

    def update_state!
      caster = parser.objects.find_or_create(record.spell_cast.caster_guid)
      caster.spell_start!(self)
    end
  end
end
