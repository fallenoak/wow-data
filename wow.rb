module WOW
  module DBC; end
  module DB2; end
  module ADT; end
  module Capture; end
end

require 'date'
require 'digest/sha1'

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

require_relative 'lib/capture/definitions'
require_relative 'lib/capture/definitions/20253/opcodes'
require_relative 'lib/capture/definitions/20253/emotes'
require_relative 'lib/capture/definitions/20253/races'
require_relative 'lib/capture/definitions/20253/text_emotes'

require_relative 'lib/capture/parser'
require_relative 'lib/capture/object_types'
require_relative 'lib/capture/guid_types'
require_relative 'lib/capture/guid128'
require_relative 'lib/capture/coordinate'
require_relative 'lib/capture/wow_object'
require_relative 'lib/capture/wow_object/utility/log'
require_relative 'lib/capture/wow_object/utility/log_items'
require_relative 'lib/capture/wow_object/utility/log_items/base'
require_relative 'lib/capture/wow_object/utility/log_items/spawn'
require_relative 'lib/capture/wow_object/utility/log_items/destroy'
require_relative 'lib/capture/wow_object/utility/log_items/move'
require_relative 'lib/capture/wow_object/utility/log_items/emote'
require_relative 'lib/capture/wow_object/utility/log_items/text_emote'
require_relative 'lib/capture/wow_object/utility/log_items/chat'
require_relative 'lib/capture/wow_object/utility/movement_state'
require_relative 'lib/capture/wow_object/manager'
require_relative 'lib/capture/wow_object/base'
require_relative 'lib/capture/wow_object/player'
require_relative 'lib/capture/wow_object/creature'
require_relative 'lib/capture/storage/object_storage'
require_relative 'lib/capture/packets'
require_relative 'lib/capture/packets/base'
require_relative 'lib/capture/packets/unhandled'
require_relative 'lib/capture/packets/invalid'

require_relative 'lib/capture/packets/smsg/auth_challenge'
require_relative 'lib/capture/packets/smsg/chat'
require_relative 'lib/capture/packets/smsg/emote'
require_relative 'lib/capture/packets/smsg/on_monster_move'
require_relative 'lib/capture/packets/smsg/query_player_name_response'
require_relative 'lib/capture/packets/smsg/text_emote'
require_relative 'lib/capture/packets/smsg/update_object'
require_relative 'lib/capture/packets/smsg/update_object/fields'
require_relative 'lib/capture/packets/smsg/update_object/field_manager'
require_relative 'lib/capture/packets/smsg/update_object/entry_types'
require_relative 'lib/capture/packets/smsg/update_object/readers'
require_relative 'lib/capture/packets/smsg/update_object/entries'

require_relative 'lib/capture/packets/cmsg/auth_session'
