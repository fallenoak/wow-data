module WOW::BLTE
  class Chunk
    attr_reader :encoding_mode, :encoded_size, :decoded_size, :data

    def initialize(encoded_data)
      @encoding_mode = encoded_data[0]
      @encoded_data = encoded_data[1..-1]
      @encoded_size = @encoded_data.length

      @data = ''
    end

    def decode
      return @data if @data.length > 0

      case @encoding_mode
      when 'N'
        @encoded_data
      when 'Z'
        decode_as_zlib
      when 'F'
        decode_as_blte
      when 'E'
        decode_as_encrypted
      else
        raise Errors::UnknownEncoding.new
      end
    end

    def decode!
      @data = decode

      @decoded_size = @data.length

      @data
    end

    private def decode_as_zlib
      zstream = Zlib::Inflate.new

      buffer = zstream.inflate(@encoded_data)

      zstream.finish
      zstream.close

      buffer
    end

    private def decode_as_blte
    end

    private def decode_as_encrypted
    end

    def inspect
      excluded_variables = []
      truncated_variables = [:@encoded_data, :@data]
      all_variables = instance_variables
      variables = all_variables - excluded_variables

      prefix = "#<#{self.class}:0x#{self.__id__.to_s(16)}"

      parts = []

      variables.each do |var|
        var_content = instance_variable_get(var)

        if truncated_variables.include?(var)
          var_content = var_content[0, 5] << '...' if var_content.length > 5
        end

        part = "#{var}=#{var_content.inspect}"

        parts << part
      end

      str = parts.empty? ? "#{prefix}>" : "#{prefix} #{parts.join(' ')}>"

      str
    end
  end
end
