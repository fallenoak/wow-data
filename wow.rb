module WOW
  module DBC; end;
  module DB2; end;
  module ADT; end;
end

require 'date'

require_relative 'lib/bit_array'

require_relative 'lib/dbc/parser'
require_relative 'lib/dbc/records'
require_relative 'lib/dbc/records/base'
require_relative 'lib/dbc/records/area_table'
require_relative 'lib/dbc/records/map'

require_relative 'lib/db2/parser'
require_relative 'lib/db2/records'
require_relative 'lib/db2/records/base'
require_relative 'lib/db2/records/item_sparse'

require_relative 'lib/adt/parser'
require_relative 'lib/adt/records'
require_relative 'lib/adt/records/base'
require_relative 'lib/adt/records/mver'
require_relative 'lib/adt/records/mhdr'
require_relative 'lib/adt/records/mcnk'
require_relative 'lib/adt/records/mfbo'
require_relative 'lib/adt/records/mh2o'

require_relative 'lib/capture/parser'
require_relative 'lib/capture/object_types'
require_relative 'lib/capture/guid_types'
require_relative 'lib/capture/guid128'
require_relative 'lib/capture/opcodes'
require_relative 'lib/capture/packets'
require_relative 'lib/capture/packets/base'
require_relative 'lib/capture/packets/unhandled'
require_relative 'lib/capture/packets/invalid'
require_relative 'lib/capture/packets/smsg/auth_challenge'
require_relative 'lib/capture/packets/smsg/on_monster_move'
require_relative 'lib/capture/packets/smsg/update_object'
require_relative 'lib/capture/packets/smsg/update_object/fields'
require_relative 'lib/capture/packets/smsg/update_object/field_manager'
require_relative 'lib/capture/packets/smsg/update_object/entry_types'
require_relative 'lib/capture/packets/smsg/update_object/readers'
require_relative 'lib/capture/packets/smsg/update_object/entries'
require_relative 'lib/capture/packets/cmsg/auth_session'
