module WOW::Capture::Packets::SMSG
  class QueryPlayerNameResponse < WOW::Capture::Packets::Base
    attr_reader :player_guid, :account_guid, :bnet_account_guid, :virtual_realm_address,
      :race_id, :gender_id, :class_id, :level, :name

    def parse!
      @has_data = read_byte == 0

      @player_guid = read_packed_guid128

      return if !@has_data

      is_deleted = read_bit

      name_length = read_bits(6)
      count = []

      (0...5).each do |i|
        count[i] = read_bits(7)
      end

      (0...5).each do |i|
        name_declined = read_char(count[i])
      end

      @account_guid = read_packed_guid128
      @bnet_account_guid = read_packed_guid128
      @player_guid = read_packed_guid128

      @virtual_realm_address = read_uint32

      @race_id = read_byte
      @gender_id = read_byte
      @class_id = read_byte
      @level = read_byte

      @race = parser.defs.races[@race_id]

      @name = read_char(name_length)
    end

    def has_data?
      @has_data == true
    end

    def update_state!
      player_object = parser.objects.find_or_create(@player_guid)

      if has_data?
        player_object.set_name!(@name)
        player_object.set_race!(@race)
      end
    end
  end
end
