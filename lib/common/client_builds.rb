module WOW
  module ClientBuilds
    BUILDS = [
      # The Burning Crusade
      { build: 6180,  era: '2.x', released: Time.utc(2006,  12, 5)  },
      { build: 6299,  era: '2.x', released: Time.utc(2007,  1,  9)  },
      { build: 6337,  era: '2.x', released: Time.utc(2007,  1,  23) },
      { build: 6692,  era: '2.x', released: Time.utc(2007,  5,  22) },
      { build: 6739,  era: '2.x', released: Time.utc(2007,  6,  5)  },
      { build: 6803,  era: '2.x', released: Time.utc(2007,  6,  19) },
      { build: 6898,  era: '2.x', released: Time.utc(2007,  7,  10) },
      { build: 7272,  era: '2.x', released: Time.utc(2007,  9,  25) },
      { build: 7318,  era: '2.x', released: Time.utc(2007,  10, 3)  },
      { build: 7359,  era: '2.x', released: Time.utc(2007,  10, 9)  },
      { build: 7561,  era: '2.x', released: Time.utc(2007,  11, 13) },
      { build: 7741,  era: '2.x', released: Time.utc(2008,  1,  8)  },
      { build: 7799,  era: '2.x', released: Time.utc(2008,  1,  22) },
      { build: 8089,  era: '2.x', released: Time.utc(2008,  3,  25) },
      { build: 8125,  era: '2.x', released: Time.utc(2008,  4,  1)  },
      { build: 8209,  era: '2.x', released: Time.utc(2008,  5,  13) },
      { build: 8606,  era: '2.x', released: Time.utc(2008,  7,  15) },

      # Wrath of the Lich King
      { build: 9056,  era: '3.x', released: Time.utc(2008,  10, 14) },
      { build: 9183,  era: '3.x', released: Time.utc(2008,  11, 4)  },
      { build: 9464,  era: '3.x', released: Time.utc(2009,  1,  20) },
      { build: 9506,  era: '3.x', released: Time.utc(2009,  1,  27) },
      { build: 9551,  era: '3.x', released: Time.utc(2009,  2,  10) },
      { build: 9767,  era: '3.x', released: Time.utc(2009,  4,  14) },
      { build: 9806,  era: '3.x', released: Time.utc(2009,  4,  21) },
      { build: 9835,  era: '3.x', released: Time.utc(2009,  4,  28) },
      { build: 9901,  era: '3.x', released: Time.utc(2009,  5,  13) },
      { build: 9947,  era: '3.x', released: Time.utc(2009,  6,  2)  },
      { build: 10192, era: '3.x', released: Time.utc(2009,  8,  4)  },
      { build: 10314, era: '3.x', released: Time.utc(2009,  8,  19) },
      { build: 10482, era: '3.x', released: Time.utc(2009,  9,  22) },
      { build: 10505, era: '3.x', released: Time.utc(2009,  9,  25) },
      { build: 10958, era: '3.x', released: Time.utc(2009,  12, 2)  },
      { build: 11159, era: '3.x', released: Time.utc(2009,  12, 14) },
      { build: 11685, era: '3.x', released: Time.utc(2010,  3,  23) },
      { build: 11723, era: '3.x', released: Time.utc(2010,  3,  26) },
      { build: 12213, era: '3.x', released: Time.utc(2010,  6,  22) },
      { build: 12340, era: '3.x', released: Time.utc(2010,  6,  29) },

      # Cataclysm
      { build: 13164, era: '4.x', released: Time.utc(2010,  10, 12) },
      { build: 13205, era: '4.x', released: Time.utc(2010,  10, 26) },
      { build: 13329, era: '4.x', released: Time.utc(2010,  11, 23) },
      { build: 13596, era: '4.x', released: Time.utc(2011,  2,  8)  },
      { build: 13623, era: '4.x', released: Time.utc(2011,  2,  11) },
      { build: 13914, era: '4.x', released: Time.utc(2011,  4,  26) },
      { build: 14007, era: '4.x', released: Time.utc(2011,  5,  5)  },
      { build: 14333, era: '4.x', released: Time.utc(2011,  6,  28) },
      { build: 14480, era: '4.x', released: Time.utc(2011,  9,  8)  },
      { build: 14545, era: '4.x', released: Time.utc(2011,  9,  30) },
      { build: 15005, era: '4.x', released: Time.utc(2011,  11, 30) },
      { build: 15050, era: '4.x', released: Time.utc(2011,  12, 2)  },
      { build: 15211, era: '4.x', released: Time.utc(2012,  1,  31) },
      { build: 15354, era: '4.x', released: Time.utc(2012,  2,  28) },
      { build: 15595, era: '4.x', released: Time.utc(2012,  4,  17) },

      # Mists of Pandaria
      { build: 16016, era: '5.x', released: Time.utc(2012,  8,  28) },
      { build: 16048, era: '5.x', released: Time.utc(2012,  9,  11) },
      { build: 16057, era: '5.x', released: Time.utc(2012,  9,  13) },
      { build: 16135, era: '5.x', released: Time.utc(2012,  10, 14) },
      { build: 16309, era: '5.x', released: Time.utc(2012,  11, 13) },
      { build: 16357, era: '5.x', released: Time.utc(2012,  12, 3)  },
      { build: 16650, era: '5.x', released: Time.utc(2013,  2,  26) },
      { build: 16669, era: '5.x', released: Time.utc(2013,  3,  6)  },
      { build: 16683, era: '5.x', released: Time.utc(2013,  3,  8)  },
      { build: 16685, era: '5.x', released: Time.utc(2013,  3,  11) },
      { build: 16701, era: '5.x', released: Time.utc(2013,  3,  14) },
      { build: 16709, era: '5.x', released: Time.utc(2013,  3,  14) },
      { build: 16716, era: '5.x', released: Time.utc(2013,  3,  15) },
      { build: 16733, era: '5.x', released: Time.utc(2013,  3,  19) },
      { build: 16769, era: '5.x', released: Time.utc(2013,  3,  25) },
      { build: 16826, era: '5.x', released: Time.utc(2013,  4,  8)  },
      { build: 16981, era: '5.x', released: Time.utc(2013,  5,  21) },
      { build: 16983, era: '5.x', released: Time.utc(2013,  5,  21) },
      { build: 16992, era: '5.x', released: Time.utc(2013,  5,  23) },
      { build: 17055, era: '5.x', released: Time.utc(2013,  6,  10) },
      { build: 17116, era: '5.x', released: Time.utc(2013,  6,  21) },
      { build: 17128, era: '5.x', released: Time.utc(2013,  6,  26) },
      { build: 17359, era: '5.x', released: Time.utc(2013,  9,  9)  },
      { build: 17371, era: '5.x', released: Time.utc(2013,  9,  11) },
      { build: 17399, era: '5.x', released: Time.utc(2013,  9,  23) },
      { build: 17538, era: '5.x', released: Time.utc(2013,  10, 25) },
      { build: 17658, era: '5.x', released: Time.utc(2013,  12, 6)  },
      { build: 17688, era: '5.x', released: Time.utc(2013,  12, 12) },
      { build: 17898, era: '5.x', released: Time.utc(2014,  2,  11) },
      { build: 17930, era: '5.x', released: Time.utc(2014,  2,  19) },
      { build: 17956, era: '5.x', released: Time.utc(2014,  2,  27) },
      { build: 18019, era: '5.x', released: Time.utc(2014,  3,  10) },
      { build: 18291, era: '5.x', released: Time.utc(2014,  5,  19) },
      { build: 18414, era: '5.x', released: Time.utc(2014,  6,  13) },

      # Warlords of Draenor
      { build: 19033, era: '6.x', released: Time.utc(2014,  10, 14) },
      { build: 19034, era: '6.x', released: Time.utc(2014,  10, 14) },
      { build: 19103, era: '6.x', released: Time.utc(2014,  10, 28) },
      { build: 19116, era: '6.x', released: Time.utc(2014,  10, 29) },
      { build: 19243, era: '6.x', released: Time.utc(2014,  11, 26) },
      { build: 19342, era: '6.x', released: Time.utc(2014,  12, 15) },
      { build: 19678, era: '6.x', released: Time.utc(2015,  2,  23) },
      { build: 19702, era: '6.x', released: Time.utc(2015,  2,  26) },
      { build: 19802, era: '6.x', released: Time.utc(2015,  3,  21) },
      { build: 19831, era: '6.x', released: Time.utc(2015,  3,  31) },
      { build: 19865, era: '6.x', released: Time.utc(2015,  4,  3)  },
      { build: 20173, era: '6.x', released: Time.utc(2015,  6,  22) },
      { build: 20182, era: '6.x', released: Time.utc(2015,  6,  25) },
      { build: 20201, era: '6.x', released: Time.utc(2015,  6,  26) },
      { build: 20216, era: '6.x', released: Time.utc(2015,  7,  2)  },
      { build: 20253, era: '6.x', released: Time.utc(2015,  7,  9)  },
      { build: 20338, era: '6.x', released: Time.utc(2015,  7,  27) },
      { build: 20444, era: '6.x', released: Time.utc(2015,  9,  1)  },
      { build: 20490, era: '6.x', released: Time.utc(2015,  9,  9)  },
      { build: 20574, era: '6.x', released: Time.utc(2015,  10, 5)  },
      { build: 20726, era: '6.x', released: Time.utc(2015,  11, 17) }
    ]

    def self.in_use_at(time)
      truncated_builds = BUILDS.select { |entry| entry[:released] <= time }
      truncated_builds.sort_by! { |entry| entry[:released] }
      truncated_builds.last[:build]
    end

    def self.build_era(build)
      BUILDS.select { |entry| entry[:build] == build }.first[:era]
    end

    def self.known?(build)
      BUILDS.select { |entry| entry[:build] == build }.length > 0
    end
  end
end
