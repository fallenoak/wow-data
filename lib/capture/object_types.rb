module WOW::Capture
  OBJECT_TYPES = {
    0   => :object,
    1   => :item,
    2   => :container,
    3   => :unit,
    4   => :player,
    5   => :game_object,
    6   => :dynamic_object,
    7   => :corpse,
    8   => :area_trigger,
    9   => :scene_object,
    10  => :conversation
  }

  OBJECT_TYPES_INVERSE = OBJECT_TYPES.invert
end
