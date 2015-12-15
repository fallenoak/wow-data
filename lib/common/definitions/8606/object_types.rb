module WOW::Definitions
  build 8606 do
    table :object_types do
      e   0,  :object,          tc_value: '',               label: 'Object'
      e   1,  :item,            tc_value: '',               label: 'Item'
      e   2,  :container,       tc_value: '',               label: 'Container'
      e   3,  :unit,            tc_value: '',               label: 'Unit'
      e   4,  :player,          tc_value: '',               label: 'Player'
      e   5,  :game_object,     tc_value: '',               label: 'Game Object'
      e   6,  :dynamic_object,  tc_value: '',               label: 'Dynamic Object'
      e   7,  :corpse,          tc_value: '',               label: 'Corpse'
      e   8,  :area_trigger,    tc_value: '',               label: 'Area Trigger'
      e   9,  :scene_object,    tc_value: '',               label: 'Scene Object'
      e   10, :conversation,    tc_value: '',               label: 'Conversation'
    end
  end
end
