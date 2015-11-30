module WOW::Capture::Packets::SMSG
  class QueryPlayerNameResponse < WOW::Capture::Packets::Base
    attr_reader :player_guid, :race_id, :gender_id, :class_id, :name, :race, :character_class,
      :realm_name

    def parse!
      @player_guid = read_packed_guid64

      @has_data = read_byte == 0

      return if !@has_data

      @name = read_string
      @realm_name = read_string

      @race_id = read_byte
      @gender_id = read_byte
      @class_id = read_byte

      @race = parser.defs.races[@race_id]
      @character_class = parser.defs.classes[@class_id]

      name_declined = read_bool

      return if !name_declined

      declined_names = []

      5.times do
        declined_names << read_string
      end
    end

    def has_data?
      @has_data == true
    end

    def update_state!
      player_object = parser.objects.find_or_create(@player_guid)

      if has_data?
        player_object.set_name!(@name)
        player_object.set_race!(@race)
        player_object.set_character_class!(@character_class)
      end
    end
  end
end
