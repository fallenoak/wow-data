module WOW::Capture::Packets::Records
  class SpellTarget < WOW::Capture::Packets::Records::Base
    structure do
      reset_bit_reader

      # todo client >= 6.1.0 19678 ? 23 : 21
      bits      :flags,                     length: 23

      bit       :has_source_location
      bit       :has_destination_location
      bit       :has_orientation

      bits      :name_length,               length: 7

      guid128   :unit_guid,                 packed: true
      guid128   :item_guid,                 packed: true

      struct    :source_location,           if: proc { has_source_location }, source: :spell_location

      struct    :destination_location,      if: proc { has_destination_location }, source: :spell_location

      float     :orientation,               if: proc { has_orientation }

      string    :name,                      length: proc { name_length }
    end
  end
end
