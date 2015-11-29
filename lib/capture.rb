module WOW
  module Capture; end
end

require_relative 'common'

require_relative 'capture/object_types'
require_relative 'capture/guid128'
require_relative 'capture/coordinate'
require_relative 'capture/update_value'

require_relative 'capture/wow_object'
require_relative 'capture/wow_object/utility/log'
require_relative 'capture/wow_object/utility/log_items'
require_relative 'capture/wow_object/utility/log_items/base'
require_relative 'capture/wow_object/utility/log_items/destroy_object'
require_relative 'capture/wow_object/utility/log_items/create_object'
require_relative 'capture/wow_object/utility/log_items/loot_response'
require_relative 'capture/wow_object/utility/log_items/move'
require_relative 'capture/wow_object/utility/log_items/emote'
require_relative 'capture/wow_object/utility/log_items/text_emote'
require_relative 'capture/wow_object/utility/log_items/chat'
require_relative 'capture/wow_object/utility/log_items/attack_start'
require_relative 'capture/wow_object/utility/log_items/attack_stop'
require_relative 'capture/wow_object/utility/log_items/died'
require_relative 'capture/wow_object/utility/log_items/spell_start'
require_relative 'capture/wow_object/utility/log_items/spell_go'
require_relative 'capture/wow_object/utility/log_items/update'
require_relative 'capture/wow_object/utility/movement_state'
require_relative 'capture/wow_object/utility/attributes'
require_relative 'capture/wow_object/base'
require_relative 'capture/wow_object/player'
require_relative 'capture/wow_object/creature'

require_relative 'capture/combat_session'

require_relative 'capture/storage/base'
require_relative 'capture/storage/object_storage'
require_relative 'capture/storage/session_storage'
require_relative 'capture/storage/combat_session_storage'

require_relative 'capture/utility/reference'

require_relative 'capture/packets'
require_relative 'capture/packets/base'
require_relative 'capture/packets/utility'
require_relative 'capture/packets/readers'
require_relative 'capture/packets/unhandled'
require_relative 'capture/packets/invalid'

require_relative 'capture/parser'
