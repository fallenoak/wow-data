module WOW::Capture::Definitions
  build 20253 do
    table :expansions do
      e   0,  :world_of_warcraft,       tc_value: 'WorldOfWarcraft'
      e   1,  :the_burning_crusade,     tc_value: 'TheBurningCrusade'
      e   2,  :wrath_of_the_lich_king,  tc_value: 'WrathOfTheLichKing'
      e   3,  :cataclysm,               tc_value: 'Cataclysm'
      e   4,  :mists_of_pandaria,       tc_value: 'MistsOfPandaria'
      e   5,  :warlords_of_draenor,     tc_value: 'WarlordsOfDraenor'
    end
  end
end
