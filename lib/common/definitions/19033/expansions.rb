module WOW::Definitions
  build 19033 do
    table :expansions do
      e   0,  :world_of_warcraft,       tc_value: 'WorldOfWarcraft',    label: 'World of Warcraft'
      e   1,  :the_burning_crusade,     tc_value: 'TheBurningCrusade',  label: 'The Burning Crusade'
      e   2,  :wrath_of_the_lich_king,  tc_value: 'WrathOfTheLichKing', label: 'Wrath of the Lich King'
      e   3,  :cataclysm,               tc_value: 'Cataclysm',          label: 'Cataclysm'
      e   4,  :mists_of_pandaria,       tc_value: 'MistsOfPandaria',    label: 'Mists of Pandaria'
      e   5,  :warlords_of_draenor,     tc_value: 'WarlordsOfDraenor',  label: 'Warlords of Draenor'
    end
  end
end
