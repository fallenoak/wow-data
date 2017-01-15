module WOW::RCAT
  class Parser
    SUPPORTED_TOKENS = %w(RCAT)

    class InvalidFormat < StandardError; end

    attr_reader :data

    def initialize(path)
      raise InvalidFormat.new('zero-length file') if ::File.size(path) == 0
      raise InvalidFormat.new('invalid file') if ::File.size(path) < 4

      file = ::File.open(path, 'rb')

      token = file.read(4)
      file.pos = 0

      raise InvalidFormat.new("invalid file token: #{token}") if !SUPPORTED_TOKENS.include?(token)

      @data = WOW::RCAT::File.read(file)

      file.close
    end
  end
end
