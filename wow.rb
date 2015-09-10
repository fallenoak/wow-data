module WOW
  module DBC; end
  module DB2; end
  module ADT; end
end

require 'date'
require 'digest/sha1'

require_relative 'lib/bit_array'

require_relative 'lib/dbc/parser'
require_relative 'lib/dbc/records'
require_relative 'lib/dbc/records/base'
require_relative 'lib/dbc/records/area_table'
require_relative 'lib/dbc/records/creature_family'
require_relative 'lib/dbc/records/file_data'
require_relative 'lib/dbc/records/gt_npc_total_hp'
require_relative 'lib/dbc/records/gt_npc_total_hp_exp1'
require_relative 'lib/dbc/records/gt_npc_total_hp_exp2'
require_relative 'lib/dbc/records/gt_npc_total_hp_exp3'
require_relative 'lib/dbc/records/gt_npc_total_hp_exp4'
require_relative 'lib/dbc/records/gt_npc_total_hp_exp5'
require_relative 'lib/dbc/records/gt_oct_base_hp_by_class'
require_relative 'lib/dbc/records/map'
require_relative 'lib/dbc/records/spell_icon'

require_relative 'lib/db2/parser'
require_relative 'lib/db2/records'
require_relative 'lib/db2/records/base'
require_relative 'lib/db2/records/item'
require_relative 'lib/db2/records/item_appearance'
require_relative 'lib/db2/records/item_sparse'
require_relative 'lib/db2/records/creature'
require_relative 'lib/db2/records/creature_difficulty'
require_relative 'lib/db2/records/creature_display_info'
require_relative 'lib/db2/records/creature_movement_info'
require_relative 'lib/db2/records/creature_type'

require_relative 'lib/adt/parser'
require_relative 'lib/adt/records'
require_relative 'lib/adt/records/base'
require_relative 'lib/adt/records/mver'
require_relative 'lib/adt/records/mhdr'
require_relative 'lib/adt/records/mbbb'
require_relative 'lib/adt/records/mbmh'
require_relative 'lib/adt/records/mbmi'
require_relative 'lib/adt/records/mbnv'
require_relative 'lib/adt/records/mcnk'
require_relative 'lib/adt/records/mfbo'
require_relative 'lib/adt/records/mh2o'

require_relative 'lib/capture'
