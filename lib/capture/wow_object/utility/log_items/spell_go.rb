module WOW::Capture::WOWObject::Utility::LogItems
  class SpellGo < Base
    attr_reader :spell_id, :spell_target

    def type
      :spell_go
    end

    def parse!
      @spell_id = @packet.spell_id

      if @packet.spell_target[:unit].type != :null
        @spell_target = @packet.spell_target[:unit]
      else
        @spell_target = @packet.spell_target[:item]
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
