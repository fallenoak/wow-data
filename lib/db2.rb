module WOW
  module DB2; end
end

require_relative 'common'

require_relative 'db2/parser'

require_relative 'db2/records'
require_relative 'db2/records/base'

require_relative 'db2/records/item'
require_relative 'db2/records/item_appearance'
require_relative 'db2/records/item_sparse'
require_relative 'db2/records/creature'
require_relative 'db2/records/creature_difficulty'
require_relative 'db2/records/creature_display_info'
require_relative 'db2/records/creature_movement_info'
require_relative 'db2/records/creature_type'
