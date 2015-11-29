module WOW
  module ClientBuilds
    BUILDS = [
      # The Burning Crusade
      { build: 6180,  released: Time.utc(2006,  12, 5)  },
      { build: 6299,  released: Time.utc(2007,  1,  9)  },
      { build: 6337,  released: Time.utc(2007,  1,  23) },
      { build: 6692,  released: Time.utc(2007,  5,  22) },
      { build: 6739,  released: Time.utc(2007,  6,  5)  },
      { build: 6803,  released: Time.utc(2007,  6,  19) },
      { build: 6898,  released: Time.utc(2007,  7,  10) },
      { build: 7272,  released: Time.utc(2007,  9,  25) },
      { build: 7318,  released: Time.utc(2007,  10, 3)  },
      { build: 7359,  released: Time.utc(2007,  10, 9)  },
      { build: 7561,  released: Time.utc(2007,  11, 13) },
      { build: 7741,  released: Time.utc(2008,  1,  8)  },
      { build: 7799,  released: Time.utc(2008,  1,  22) },
      { build: 8089,  released: Time.utc(2008,  3,  25) },
      { build: 8125,  released: Time.utc(2008,  4,  1)  },
      { build: 8209,  released: Time.utc(2008,  5,  13) },
      { build: 8606,  released: Time.utc(2008,  7,  15) },

      # Wrath of the Lich King
      { build: 9056,  released: Time.utc(2008,  10, 14) },
      { build: 9183,  released: Time.utc(2008,  11, 4)  },
      { build: 9464,  released: Time.utc(2009,  1,  20) },
      { build: 9506,  released: Time.utc(2009,  1,  27) },
      { build: 9551,  released: Time.utc(2009,  2,  10) },
      { build: 9767,  released: Time.utc(2009,  4,  14) },
      { build: 9806,  released: Time.utc(2009,  4,  21) },
      { build: 9835,  released: Time.utc(2009,  4,  28) },
      { build: 9901,  released: Time.utc(2009,  5,  13) },
      { build: 9947,  released: Time.utc(2009,  6,  2)  },
      { build: 10192, released: Time.utc(2009,  8,  4)  },
      { build: 10314, released: Time.utc(2009,  8,  19) },
      { build: 10482, released: Time.utc(2009,  9,  22) },
      { build: 10505, released: Time.utc(2009,  9,  25) },
      { build: 10958, released: Time.utc(2009,  12, 2)  },
      { build: 11159, released: Time.utc(2009,  12, 14) },
      { build: 11685, released: Time.utc(2010,  3,  23) },
      { build: 11723, released: Time.utc(2010,  3,  26) },
      { build: 12213, released: Time.utc(2010,  6,  22) },
      { build: 12340, released: Time.utc(2010,  6,  29) },

      # Cataclysm
      { build: 13164, released: Time.utc(2010,  10, 12) },
      { build: 13205, released: Time.utc(2010,  10, 26) },
      { build: 13329, released: Time.utc(2010,  11, 23) },
      { build: 13596, released: Time.utc(2011,  2,  8)  },
      { build: 13623, released: Time.utc(2011,  2,  11) },
      { build: 13914, released: Time.utc(2011,  4,  26) },
      { build: 14007, released: Time.utc(2011,  5,  5)  },
      { build: 14333, released: Time.utc(2011,  6,  28) },
      { build: 14480, released: Time.utc(2011,  9,  8)  },
      { build: 14545, released: Time.utc(2011,  9,  30) },
      { build: 15005, released: Time.utc(2011,  11, 30) },
      { build: 15050, released: Time.utc(2011,  12, 2)  },
      { build: 15211, released: Time.utc(2012,  1,  31) },
      { build: 15354, released: Time.utc(2012,  2,  28) },
      { build: 15595, released: Time.utc(2012,  4,  17) },

      # Mists of Pandaria
      { build: 16016, released: Time.utc(2012,  8,  28) },
      { build: 16048, released: Time.utc(2012,  9,  11) },
      { build: 16057, released: Time.utc(2012,  9,  13) },
      { build: 16135, released: Time.utc(2012,  10, 14) },
      { build: 16309, released: Time.utc(2012,  11, 13) },
      { build: 16357, released: Time.utc(2012,  12, 3)  },
      { build: 16650, released: Time.utc(2013,  2,  26) },
      { build: 16669, released: Time.utc(2013,  3,  6)  },
      { build: 16683, released: Time.utc(2013,  3,  8)  },
      { build: 16685, released: Time.utc(2013,  3,  11) },
      { build: 16701, released: Time.utc(2013,  3,  14) },
      { build: 16709, released: Time.utc(2013,  3,  14) },
      { build: 16716, released: Time.utc(2013,  3,  15) },
      { build: 16733, released: Time.utc(2013,  3,  19) },
      { build: 16769, released: Time.utc(2013,  3,  25) },
      { build: 16826, released: Time.utc(2013,  4,  8)  },
      { build: 16981, released: Time.utc(2013,  5,  21) },
      { build: 16983, released: Time.utc(2013,  5,  21) },
      { build: 16992, released: Time.utc(2013,  5,  23) },
      { build: 17055, released: Time.utc(2013,  6,  10) },
      { build: 17116, released: Time.utc(2013,  6,  21) },
      { build: 17128, released: Time.utc(2013,  6,  26) },
      { build: 17359, released: Time.utc(2013,  9,  9)  },
      { build: 17371, released: Time.utc(2013,  9,  11) },
      { build: 17399, released: Time.utc(2013,  9,  23) },
      { build: 17538, released: Time.utc(2013,  10, 25) },
      { build: 17658, released: Time.utc(2013,  12, 6)  },
      { build: 17688, released: Time.utc(2013,  12, 12) },
      { build: 17898, released: Time.utc(2014,  2,  11) },
      { build: 17930, released: Time.utc(2014,  2,  19) },
      { build: 17956, released: Time.utc(2014,  2,  27) },
      { build: 18019, released: Time.utc(2014,  3,  10) },
      { build: 18291, released: Time.utc(2014,  5,  19) },
      { build: 18414, released: Time.utc(2014,  6,  13) },

      # Warlords of Draenor
      { build: 19033, released: Time.utc(2014,  10, 14) },
      { build: 19034, released: Time.utc(2014,  10, 14) },
      { build: 19103, released: Time.utc(2014,  10, 28) },
      { build: 19116, released: Time.utc(2014,  10, 29) },
      { build: 19243, released: Time.utc(2014,  11, 26) },
      { build: 19342, released: Time.utc(2014,  12, 15) },
      { build: 19678, released: Time.utc(2015,  2,  23) },
      { build: 19702, released: Time.utc(2015,  2,  26) },
      { build: 19802, released: Time.utc(2015,  3,  21) },
      { build: 19831, released: Time.utc(2015,  3,  31) },
      { build: 19865, released: Time.utc(2015,  4,  3)  },
      { build: 20173, released: Time.utc(2015,  6,  22) },
      { build: 20182, released: Time.utc(2015,  6,  25) },
      { build: 20201, released: Time.utc(2015,  6,  26) },
      { build: 20216, released: Time.utc(2015,  7,  2)  },
      { build: 20253, released: Time.utc(2015,  7,  9)  },
      { build: 20338, released: Time.utc(2015,  7,  27) }
    ]

    def self.in_use_at(time)
      truncated_builds = BUILDS.select { |entry| entry[:released] <= time }
      truncated_builds.sort_by! { |entry| entry[:released] }
      truncated_builds.last[:build]
    end

    def self.known?(build)
      BUILDS.select { |entry| entry[:build] == build }
    end
  end
end
