module WOW::Capture
  class Guid128
    HighTypes = {
      0   => :null,
      1   => :uniq,
      2   => :player,
      3   => :item,
      4   => :static_door,
      5   => :transport,
      6   => :conversation,
      7   => :creature,
      8   => :vehicle,
      9   => :pet,
      10  => :game_object,
      11  => :dynamic_object,
      12  => :area_trigger,
      13  => :corpse,
      14  => :loot_object,
      15  => :scene_object,
      16  => :scenario,
      17  => :ai_group,
      18  => :dynamic_door,
      19  => :client_actor,
      20  => :vignette,
      21  => :call_for_help,
      22  => :ai_resource,
      23  => :ai_lock,
      24  => :ai_lock_ticket,
      25  => :chat_channel,
      26  => :party,
      27  => :guild,
      28  => :wow_account,
      29  => :bnet_account,
      30  => :gm_task,
      31  => :mobile_session,
      32  => :raid_group,
      33  => :spell,
      34  => :mail,
      35  => :web_obj,
      36  => :lfg_object,
      37  => :lfg_list,
      38  => :user_router,
      39  => :pvp_queue_group,
      40  => :user_client,
      41  => :pet_battle,
      42  => :unique_user_client,
      43  => :battle_pet
    }

    attr_reader :realm_id, :server_id, :object_type, :map_id, :entry_id

    def initialize(low, high)
      @high_type_id = (high >> 58) & 0x3F
      @sub_type_id = (high & 0x3F)
      @object_type = get_object_type

      @realm_id = (high >> 42) & 0x1FFF
      @server_id = (low >> 40) & 0xFFFFFF
      @map_id = (high >> 29) & 0x1FFF
      @entry_id = (high >> 6) & 0x7FFFFF
    end

    private def get_object_type
      HighTypes[@high_type_id]
    end
  end
end
