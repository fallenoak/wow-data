module WOW::Capture::Packets
  class Structure
    def self.reader(method_name)
      internal_method_name = "internal_#{method_name}"

      alias_method(internal_method_name, method_name)

      class_eval <<-EORUBY, __FILE__, __LINE__ + 1
        def #{method_name}(name = nil, opts = {}, &block)
          return if halted?

          name, opts = resolve_name_and_opts(name, opts)

          if !opts[:if].nil?
            return nil if !evaluate_conditional(opts[:if])
          end

          value = #{internal_method_name}(name, opts, &block)

          if !opts[:mask].nil?
            value = value & evaluate_option(opts[:mask])
          end

          if !opts[:remap].nil? && !definitions[opts[:remap]].nil?
            value = definitions[opts[:remap]].find(value) || value
          end

          accumulated_values << value if accumulate?

          return value if name.nil?

          record.set_attribute(name, value, opts[:private])

          value
        end
      EORUBY

      method_name
    end

    def initialize(&structure)
      @structure = structure

      @halted = false
      @accumulate = false
      @accumulated_values = []
    end

    def parse!(record, stream, client_build, definitions)
      @record = record
      @stream = stream
      @client_build = client_build
      @definitions = definitions

      output = instance_eval(&@structure)

      reset

      output
    end

    private def halted?
      @halted == true
    end

    private def accumulate?
      @accumulate == true
    end

    private def accumulate!
      @accumulate = true
      @accumulated_values = []
    end

    private def stop_accumulation!
      @accumulated_values = []
    end

    private def accumulated_values
      @accumulated_values
    end

    private def reset
      @record = nil
      @stream = nil
      @client_build = nil
      @definitions = nil

      @halted = false

      @accumulate = false
      @accumulated_values = []
    end

    private def record
      @record
    end

    private def stream
      @stream
    end

    private def client_build
      @client_build
    end

    private def definitions
      @definitions
    end

    private def resolve_name_and_opts(name, opts)
      if name.is_a?(Hash)
        [nil, name]
      else
        [name, opts]
      end
    end

    private def evaluate_conditional(conditional)
      conditional.nil? ? true : record.instance_eval(&conditional) == true
    end

    private def evaluate_option(option, default = nil)
      return default if option.nil?
      option.is_a?(Proc) ? record.instance_eval(&option) : option
    end

    private def build(target, &local_definition)
      return if halted?

      target = Range.new(target, Float::INFINITY) if !target.is_a?(Range)

      if target.include?(@client_build)
        instance_eval(&local_definition)
      end
    end

    private def opcode(opcode, &local_definition)
      return if halted?

      if record.root.packet.header.opcode == opcode
        instance_eval(&local_definition)
      end
    end

    private def cond(opts = {}, &local_definition)
      return if halted?
      return if !evaluate_conditional(opts[:if])

      instance_eval(&local_definition)
    end

    private def halt(opts = {})
      return if !evaluate_conditional(opts[:if])

      @halted = true
    end

    # Copy an attribute from another path to the given name at the current path.
    private def copy(name, opts = {})
      return if halted?

      value = record.instance_eval(&opts[:source])

      record[name] = value
    end

    # Write out the given source byte array using the provided content proc.
    private def write(name, opts = {}, &content)
      return if halted?

      source = evaluate_option(opts[:source])
      length = evaluate_option(opts[:length])
      reverse = evaluate_option(opts[:reverse]) || false

      source_data = source.map { |v| v.nil? ? "\x00" : v.chr }.join

      if !length.nil? && source_data.bytesize != length
        (length - source_data.bytesize).times { source_data << "\x00" }
      end

      source_data.reverse! if reverse

      source_stream = WOW::Capture::Stream.new(stream.parser, source_data)

      inlined_structure = Structure.new(&content)
      inlined_record = Records::Inline.new(inlined_structure, record.root)
      value = inlined_record.parse!(source_stream, client_build, definitions)

      record[name] = value
    end

    private def reset_bit_reader
      return if halted?

      stream.reset_bit_reader
    end

    private reader def packet(name, opts = {})
      opcode = evaluate_option(opts[:opcode])
      data = evaluate_option(opts[:data])

      if data == :immediate
        data = stream
      end

      stream.parser.create_inline_packet(record.root.packet, opcode, data)
    end

    private reader def inflate(name, opts = {})
      inflated_length = evaluate_option(opts[:inflated_length])
      preserve_context = evaluate_option(opts[:preserve_context])

      inflate_opts = {
        inflated_length: inflated_length,
        preserve_context: preserve_context
      }

      inflated_value = stream.read_inflate(inflate_opts)

      if !opts[:as].nil?
        sourced_record_class = WOW::Capture::Packets::Records.named(opts[:as])
        raise StandardError.new("Unknown record: #{opts[:as]}") if sourced_record_class.nil?

        sourced_stream = WOW::Capture::Stream.new(stream.parser, inflated_value)

        sourced_record = sourced_record_class.new(record.root)
        sourced_record.parse!(sourced_stream, client_build, definitions)

        value = sourced_record

        record.merge!(value) if opts[:merge]
      else
        value = inflated_value
      end

      value
    end

    private reader def guid128(name, opts = {})
      if opts[:packed] == true
        value = stream.read_packed_guid128
      else
        value = stream.read_guid128
      end

      value
    end

    private reader def guid64(name, opts = {})
      if !opts[:bitstream].nil?
        value = stream.read_bitstream_guid64(opts[:bitstream][0], opts[:bitstream][1])
      elsif opts[:packed] == true
        value = stream.read_packed_guid64
      else
        value = stream.read_guid64
      end

      value
    end

    private reader def array(name, opts = {}, &content_type)
      length = evaluate_option(opts[:length])

      value = []

      if length == :all
        while !stream.eof?
          if content_type.arity == 1
            value << instance_exec(index, &content_type)
          else
            value << instance_eval(&content_type)
          end
        end
      else
        length = length.to_i

        length.times do |index|
          if content_type.arity == 1
            value << instance_exec(index, &content_type)
          else
            value << instance_eval(&content_type)
          end
        end
      end

      value
    end

    # Interleaved Array
    private def iarray(names, opts = {}, &content)
      return if halted?

      length = evaluate_option(opts[:length])

      interleaved = []

      length.times do |index|
        accumulate!

        if content.arity == 1
          instance_exec(index, &content)
        else
          instance_eval(&content)
        end

        interleaved << accumulated_values

        stop_accumulation!
      end

      names.each do |name|
        next if name.nil?
        record[name] = []
      end

      interleaved.each do |array|
        names.each_with_index do |name, value_index|
          next if name.nil?
          record[name] << array[value_index]
        end
      end
    end

    # Byte Array Element
    private def byteae(name, opts = {})
      return if halted?

      record[name] = [] if !record.has_key?(name)

      index = evaluate_option(opts[:index]) || record[name].length

      xor = evaluate_option(opts[:xor])
      xor = record[xor] if xor.is_a?(Symbol)

      mask = evaluate_option(opts[:mask])
      mask = record[mask] if mask.is_a?(Symbol)

      if xor.nil?
        if mask.nil? || mask[index] == 1
          value = stream.read_uint8
        else
          value = 0
        end
      else
        xor_value = xor[index]
        xor_value = 0 if xor_value == false
        xor_value = 1 if xor_value == true

        if xor_value != 0
          value = stream.read_uint8
          value = xor_value ^ value
        else
          value = 0
        end
      end

      record[name][index] = value
    end

    # Bit Array Element
    private def bitae(name, opts = {})
      return if halted?

      record[name] = [] if !record.has_key?(name)

      index = evaluate_option(opts[:index]) || record[name].length

      xor = evaluate_option(opts[:xor])
      xor = record[xor] if xor.is_a?(Symbol)

      binary = evaluate_option(opts[:binary]) || false

      if xor.nil?
        value = stream.read_bit
        value = value ? 1 : 0 if binary == true
      else
        xor_value = xor[index]
        xor_value = 0 if xor_value == false
        xor_value = 1 if xor_value == true

        if xor_value != 0
          value = stream.read_bit
          value = value ? 1 : 0 if binary == true
          value = xor_value ^ value
        else
          value = 0
        end
      end

      record[name][index] = value
    end

    private reader def struct(name, opts = {}, &local_definition)
      if !opts[:source].nil?
        sourced_record_class = WOW::Capture::Packets::Records.named(opts[:source])
        raise StandardError.new("Unknown record: #{opts[:source]}") if sourced_record_class.nil?

        sourced_record = sourced_record_class.new(record.root)
        sourced_record.parse!(stream, client_build, definitions)

        value = sourced_record
      else
        inlined_structure = Structure.new(&local_definition)
        inlined_record = Records::Inline.new(inlined_structure, record.root)
        inlined_record.parse!(stream, client_build, definitions)

        value = inlined_record
      end

      record.merge!(value) if opts[:merge]

      value
    end

    private reader def int8(name, opts = {})
      stream.read_int8
    end

    private reader def uint8(name, opts = {})
      stream.read_uint8
    end

    private reader def int16(name, opts = {})
      stream.read_int16
    end

    private reader def uint16(name, opts = {})
      stream.read_uint16
    end

    private reader def int32(name, opts = {})
      stream.read_int32
    end

    private reader def uint32(name, opts = {})
      stream.read_uint32
    end

    private reader def bit(name, opts = {})
      stream.read_bit
    end

    private reader def bits(name, opts = {})
      length = opts[:length]

      stream.read_bits(length)
    end

    private reader def coord(name, opts = {})
      opts[:format] == :xyzo ? stream.read_coord(4) : stream.read_coord(3)
    end

    private reader def vector(name, opts = {})
      length = evaluate_option(opts[:length])

      stream.read_vector(length)
    end

    private reader def time(name, opts = {})
      if opts[:packed] == true
        value = stream.read_packed_time
      else
        value = stream.read_time
      end

      value
    end

    private reader def qtern(name, opts = {})
      if opts[:packed] == true
        value = stream.read_packed_quaternion
      else
        value = stream.read_quaternion
      end

      value
    end

    private reader def float(name, opts = {})
      stream.read_float
    end

    private reader def string(name, opts = {})
      length = opts[:length]

      if length.is_a?(Proc)
        length = record.instance_eval(&length)
      end

      length.nil? ? stream.read_cstring : stream.read_string(length)
    end

    private reader def bool(name, opts = {})
      stream.read_bool
    end

    private reader def invbool(name, opts = {})
      !stream.read_bool
    end

    private reader def bitarray(name, opts = {})
      length = evaluate_option(opts[:length])

      stream.read_bitarray(length)
    end

    private reader def objvals(name, opts = {})
      object_type = evaluate_option(opts[:object_type])

      stream.read_object_values(object_type)
    end
  end
end
