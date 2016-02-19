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

    if options[:pretty]
      opening = "{\n    \"packets\": ["
    else
      opening = "{\"packets\":["
    end

    output_file.write(opening)

    first_packet = true

    capture.on(:packet) do |packet|
      print "\r-> Progress: #{(capture.progress * 100).round}% ##{packet.header.index} (#{capture.pos} / #{capture.file_size})"

      if !(include_opcodes.nil? || include_opcodes.empty?)
        next if packet.header.opcode.nil?
        next if !include_opcodes.include?(packet.header.opcode.label)
      elsif !(exclude_opcodes.nil? || exclude_opcodes.empty?)
        next if packet.header.opcode.nil?
        next if exclude_opcodes.include?(packet.header.opcode.label)
      end

      next if skip_unhandled && !packet.handled?

      output_file.write(',') if !first_packet

      if options[:pretty]
        raw_output = JSON.pretty_generate(packet.to_h, indent: (' ' * 4))
        output = raw_output.split("\n").map { |line| "        #{line}" }.join("\n")
        output_file.write("\n#{output}")
      else
        output_file.write(packet.to_json)
      end

      first_packet = false if first_packet
    end

    puts '-> Replaying capture'

    if skip_unhandled
      puts '-> Skipping unhandled packets'
    end

    capture.replay!

    if options[:pretty]
      closing = "\n    ]\n}"
    else
      closing = "]}"
    end

    output_file.write(closing)

    output_file.close

    capture.close

    puts
    puts '-> Finished!'
  end
end

JSONExporter.new
