module WOW::Capture::WOWObject::Utility::LogItems
  class SpellStart < Base
    attr_reader :spell_id, :spell_target

    def type
      :spell_start
    end

    def parse!
      spell_cast = packet.record.spell_cast

      @spell_id = spell_cast.spell_id

      if spell_cast.spell_target.unit_guid.type != :null
        @spell_target = spell_cast.spell_target.unit_guid
      else
        @spell_target = spell_cast.spell_target.item_guid
      end
    end

    def pretty_print
      output = ''

      output << pretty_prefix

      output << " Spell ID:   #{@spell_id}"
      output << pretty_line
      output << " Target Obj: #{@spell_target.pretty_print}"

      output
    end
  end
end
