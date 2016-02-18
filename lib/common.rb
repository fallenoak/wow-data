module WOW; end

require 'date'
require 'digest/sha1'
require 'stringio'
require 'json'
require 'zlib'

require_relative 'common/bit_array'
require_relative 'common/client_builds'
require_relative 'common/definitions'

Dir.glob("#{File.dirname(__FILE__)}/common/definitions/**/*.rb").each do |definitions_file|
  require definitions_file
end
