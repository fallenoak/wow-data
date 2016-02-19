require 'json'
require 'optparse'

require_relative '../lib/capture'

class JSONExporter
  def initialize
    puts 'wow-data JSON Exporter'

    options = parse_options

    case options.delete(:mode)
    when 'events'
      events_to_json(options)
    else
      packets_to_json(options)
    end
  end

  def parse_options
    options = {}

    parser = OptionParser.new do |opts|
      opts.banner = 'Usage: ruby export_json.rb [options] <input_path>'

      opts.on('-m', '--mode', 'Export mode: packets or events') do |m|
        options[:mode] = m
      end

      opts.on('-o', '--output', 'Output path: defaults to input path + .json') do |o|
        options[:output_path] = o
      end

      opts.on('-p', '--pretty', 'Pretty print the output (adds significant size!)') do |p|
        options[:pretty] = true
      end

      opts.on('-e', '--exclude-opcodes x,y,z', Array, 'Skip listed opcodes; includes all opcodes except listed; comma separated, eg. SMSG_ATTACK_START,SMSG_ATTACK_STOP') do |e|
        options[:exclude_opcodes] = e
      end

      opts.on('-i', '--include-opcodes x,y,z', Array, 'Only include listed opcodes; excludes all opcodes except listed; comma separated, eg. SMSG_ATTACK_START,SMSG_ATTACK_STOP') do |i|
        options[:include_opcodes] = i
      end

      opts.on('-s', '--skip-unhandled', 'Skip unhandled packets (may still include packets that are missing specific build support)') do |s|
        options[:skip_unhandled] = true
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
      options[:output_path] = input_path + '.json'
    end

    options
  end

  def packets_to_json(options)
    puts
    puts "Output Path: #{options[:output_path]}"
    puts

    puts 'Exporting packets to JSON...'

    input_path = options[:input_path]
    output_path = options[:output_path]

    include_opcodes = options[:include_opcodes]
    exclude_opcodes = options[:exclude_opcodes]

    skip_unhandled = options[:skip_unhandled] == true

    output_file = File.open(output_path, 'w')

    capture = WOW::Capture::Parser.new(input_path)

    h = {
      capture: {
        packets: []
      }
    }

    capture.on(:packet) do |packet|
      if !(include_opcodes.nil? || include_opcodes.empty?)
        next if packet.header.opcode.nil?
        next if !include_opcodes.include?(packet.header.opcode.tc_value)
      elsif !(exclude_opcodes.nil? || exclude_opcodes.empty?)
        next if packet.header.opcode.nil?
        next if exclude_opcodes.include?(packet.header.opcode.tc_value)
      end

      next if skip_unhandled && !packet.handled?

      h[:capture][:packets] << packet.to_h
    end

    puts '-> Replaying capture'

    capture.replay!

    puts '-> Writing JSON'

    if options[:pretty]
      output_file.write(JSON.pretty_generate(h, indent: (' ' * 4)))
    else
      output_file.write(h.to_json)
    end

    output_file.close

    capture.close

    puts '-> Finished!'
  end
end

JSONExporter.new
