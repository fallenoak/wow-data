module WOW
  module DBC; end;
  module DB2; end;
end

require_relative 'lib/dbc/parser'
require_relative 'lib/dbc/records'
require_relative 'lib/dbc/records/base'
require_relative 'lib/dbc/records/area_table'
require_relative 'lib/dbc/records/map'

require_relative 'lib/db2/parser'
require_relative 'lib/db2/records'
require_relative 'lib/db2/records/base'
require_relative 'lib/db2/records/item_sparse'
