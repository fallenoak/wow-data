module WOW::NGDP
  class Response
    class Header
      attr_reader :attribute, :format

      def initialize(attribute, format)
        @attribute = attribute
        @format = format
      end
    end

    class Row
      attr_reader :attributes

      def initialize
        @attributes = {}
      end

      def [](key)
        @attributes[key]
      end

      def []=(key, value)
        @attributes[key] = value
      end
    end

    attr_reader :headers, :rows

    def initialize(data)
      @headers = parse_headers(data)
      @rows = parse_rows(data)
    end

    def merge!(data)
      # Allow merging NGPDs as either objects or plain text
      data = data.to_ngdp if data.is_a?(WOW::NGDP::Response)

      # Nothing to do if response being merged was empty
      return if data.strip.empty?

      # Parse headers
      headers = parse_headers(data)

      # Merge headers
      merge_headers(headers)

      # Now that headers are merged, parse rows
      rows = parse_rows(data)

      # Merge rows on merge keys
      merge_rows(rows)
    end

    def each(&block)
      @rows.each(&block)
    end

    def to_ngdp
      output = ''

      # Headers
      output << @headers.map { |h| [h.attribute, h.format].join('!') }.join('|')
      output << "\n"

      # Rows
      @rows.each do |row|
        raw_row = []

        @headers.each do |header|
          raw_row << row.attributes[header.attribute]
        end

        output << raw_row.join("|")
        output << "\n"
      end

      output
    end

    private def merge_headers(headers)
      headers.each do |header|
        @headers << header if !has_header?(header)
      end
    end

    private def merge_rows(rows)
      rows.each do |row|
        @rows << row if !has_row?(row)
      end
    end

    private def has_header?(header)
      @headers.select { |ex_header| ex_header.attribute == header.attribute }.length > 0
    end

    private def has_row?(row)
      @rows.select { |ex_row| match_row(ex_row, row) }.length > 0
    end

    private def match_row(row_a, row_b)
      return false if row_a.attributes.keys.length != row_b.attributes.keys.length

      row_a.attributes.each_pair do |attribute, value|
        return false if row_b.attributes[attribute] != value
      end

      true
    end

    private def parse_headers(data)
      headers = []

      rows = data.split("\n")

      rows[0].split('|').each do |col|
        attribute, format = col.split('!')
        header = Header.new(attribute, format)
        headers << header
      end

      headers
    end

    private def parse_rows(data)
      raw_rows = data.split("\n")

      parsed_rows = []

      raw_rows[1..-1].each do |raw_row|
        cols = raw_row.split('|')

        parsed_row = Row.new

        @headers.each_with_index do |header, index|
          parsed_row[header.attribute] = cols[index]
        end

        parsed_rows << parsed_row
      end

      parsed_rows
    end
  end
end
