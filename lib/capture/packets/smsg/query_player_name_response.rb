module WOW::Capture::Packets::SMSG
  class QueryPlayerNameResponse < WOW::Capture::Packets::Base
    structure do
      build 19033 do
        invbool   :has_data

        guid128   :player_guid,             packed: true

        halt      if: proc { !has_data }

        bit       :is_deleted

        bits      :name_length,             length: 6

        array     :name_declined_lengths,   length: 5 do
                    bits length: 7
                  end

        array     :name_declined,           length: 5 do |index|
                    string length: proc { name_declined_lengths[index] }
                  end

        guid128   :account_guid,            packed: true
        guid128   :bnet_account_guid,       packed: true
        guid128   :player_guid,             packed: true

        uint32    :virtual_realm_address

        uint8     :race,                    remap: :races
        uint8     :gender
        uint8     :character_class,         remap: :classes
        uint8     :level

        string    :name,                    length: proc { name_length }
      end

      build 0...16981 do
        build 9767 do
          guid64  :player_guid,             packed: true
          invbool :has_data

          halt    if: proc { !has_data }
        end

        build 0...9767 do
          guid64  :player_guid
        end

        string    :name

        string    :realm_name

        build 9767 do
          uint8   :race,                    remap: :races
          uint8   :gender
          uint8   :character_class,         remap: :classes
        end

        build 0...9767 do
          int32   :race,                    remap: :races
          int32   :gender
          int32   :character_class,         remap: :classes
        end

        bool      :name_declined

        halt      if: proc { !name_declined }

        array     :name_declined,           length: 5 do
                    string
                  end
      end
    end

    def has_data?
      record.has_data == true || record.has_data.nil?
    end

    def update_state!
      player_object = parser.objects.find_or_create(record.player_guid)

      if has_data?
        player_object.set_name!(record.name)
        player_object.set_race!(record.race)
        player_object.set_character_class!(record.character_class)
      end
    end
  end
end
