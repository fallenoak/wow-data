require 'json'
require 'optparse'

require_relative '../lib/dbc'
require_relative '../lib/db2'

class DBCExporter
  def initialize
    puts 'wow-data DBC/DB2 Exporter'

    options = parse_options

    dbc_to_csv(options)
  end

  def parse_options
    options = {}

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ruby export_dbc.rb [options] <input_path>'

      opts.on('-o <output_path>', '--output <output_path>', 'Output path: defaults to input path + .csv') do |o|
        options[:output_path] = o
      end

      opts.on_tail('-h', '--help', 'Display argument information') do
        puts opts
        exit
      end
    end

    parser.parse!

    input_path = ARGV.pop

    if input_path.nil? || input_path.empty?
      puts
      puts 'ERROR: Must specify input file path'
      puts
      puts parser
      exit
    end

    options[:input_path] = input_path

    if options[:output_path].nil? || options[:output_path].empty?
      options[:output_path] = input_path + '.csv'
    end

    options
  end

  def dbc_to_csv(options)
    puts
    puts "Output Path: #{options[:output_path]}"
    puts

    puts 'Exporting file to CSV...'
    puts

    input_path = options[:input_path]
    output_path = options[:output_path]

    if input_path.end_with?('.dbc')
      parser = WOW::DBC::Parser.new(input_path, lazy: true)
    elsif input_path.end_with?('.db2')
      parser = WOW::DB2::Parser.new(input_path, lazy: true)
    else
      raise 'Unexpected file format!'
    end

    puts "-> Matched build and locale: #{parser.build} #{parser.locale}"

    csv = ''

    while !parser.eof? do
      record = parser.next_record

      csv << record_to_csv_header(record) if csv == ''
      csv << "\n"
      csv << record_to_csv_row(record)
    end

    parser.close

    output_file = File.open(output_path, 'wb')
    output_file.write(csv)
    output_file.close

    puts '-> Finished!'
  end

  private def record_to_csv_header(record)
    header = []

    record.fields.keys.each do |field_name|
      header << "\"#{escape_csv(field_name)}\""
    end

    header.join(',')
  end

  private def record_to_csv_row(record)
    row = []

    record.fields.each_pair do |field_name, field_value|
      row << "\"#{escape_csv(field_value)}\""
    end

    row.join(',')
  end

  private def escape_csv(value)
    if value.is_a?(String)
      value.gsub('"', '""')
    else
      value
    end
  end
end

DBCExporter.new
