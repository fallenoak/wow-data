module WOW::Capture::Utility
  class Zmanager
    MAX_CONTEXTS = 4

    attr_reader :last_valid_context

    def initialize
      @streams = []
      @last_valid_context = nil
    end

    def inflate(buffer, inflated_length = nil)
      MAX_CONTEXTS.times do |context|
        if @streams[context].nil?
          @streams[context] = Zlib::Inflate.new
        end

        stream = @streams[context]

        begin
          inflated = stream.inflate(buffer)
          @last_valid_context = context

          return inflated
        rescue Zlib::BufError, Zlib::DataError => e
          if context < MAX_CONTEXTS - 1
            next
          else
            raise e
          end
        end
      end
    end

    def reset_context(context)
      if context.nil?
        context = @streams.length - 1
      end

      #@streams[context] = Zlib::Inflate.new

      puts "RESET CONTEXT #{context}"
      puts "OR WAS IT: #{last_valid_context}"
    end

    def inflate2(buffer, inflated_length = nil)
      puts "NEW RUN"
      fresh_stream = Zlib::Inflate.new

      # Attempt fresh stream.
      begin
        inflated = fresh_stream.inflate(buffer)
        @streams << fresh_stream
        puts "Fresh stream success!"
        return inflated
      rescue Zlib::BufError, Zlib::DataError => fresh_e
        puts "Fresh stream failed: #{fresh_e}"
        existing_e = nil

        @streams.each do |existing_stream|
          begin
            inflated = existing_stream.inflate(buffer)
            puts "Existing stream success!"
            return inflated
          rescue Zlib::BufError, Zlib::DataError => existing_e
            puts "Existing stream failed: #{existing_e}"
            next
          end
        end

        raise existing_e || fresh_e
      end
    end
  end
end
