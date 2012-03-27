# encoding: UTF-8

require 'strscan'

module BEncodr
  module Parser
    class << self
      # This method parases a bencoded object.
      #
      #   scanner = StringScanner.new("6:string")
      #   BEncodr::Parser.parse_object(scanner) #=> "string"
      #
      # @param [StringScanner] scanner the scanner of a bencoded object
      # @return [::String, ::Integer, ::Hash, ::Array, nil] an object if type is recognized or nil
      def parse_object(scanner)
        case scanner.peek(1)[0]
          when ?0..?9
            parse_string(scanner)
          when ?i
            parse_integer(scanner)
          when ?l
            parse_list(scanner)
          when ?d
            parse_dictionary(scanner)
          else
            nil
        end
      end

      # This method parases a bencoded string.
      #
      #   scanner = StringScanner.new("6:string")
      #   BEncodr::Parser.parse_string(scanner) #=> "string"
      #
      # @param [StringScanner] scanner the scanner of a bencoded string
      # @return [::String] the parsed string
      def parse_string(scanner)
        length = scanner.scan(/[1-9][0-9]*|0/)        or raise BEncodeError, "Invalid string: length invalid. #{scanner.pos}"
        scanner.scan(/:/)                             or raise BEncodeError, "Invalid string: missing colon(:). #{scanner.pos}"
        byte_string = scanner.scan(/.{#{length}}/m)   or raise BEncodeError, "Invalid string: length too long(#{length}) #{scanner.pos}."
        if RUBY_VERSION =~ /1\.9/
          byte_string.encode('UTF-8') rescue byte_string.force_encoding('UTF-8')
        else
          byte_string
        end
      end

      # This method parases a bencoded integer.
      #
      #   scanner = StringScanner.new("i1e")
      #   BEncodr::Parser.parse_integer(scanner) #=> 1
      #
      # @param [StringScanner] scanner the scanner of a bencoded integer
      # @return [::Integer] the parsed integer
      def parse_integer(scanner)
        scanner.scan(/i/)                         or raise BEncodeError, "Invalid integer: missing opening i. #{scanner.pos}"
        integer = scanner.scan(/-?[1-9][0-9]*|0/) or raise BEncodeError, "Invalid integer: valid integer not found. #{scanner.pos}"
        scanner.scan(/e/)                         or raise BEncodeError, "Invalid integer: missing closing e. #{scanner.pos}"
        integer.to_i
      end

      # This method parases a bencoded list.
      #
      #   scanner = StringScanner.new("le")
      #   BEncodr::Parser.parse_list(scanner) #=> []
      #
      # @param [StringScanner] scanner the scanner of a bencoded list
      # @return [::Array] the parsed array
      def parse_list(scanner)
        list = []

        scanner.scan(/l/) or raise BEncodeError, "Invalid list: missing opening l. #{scanner.pos}"
        while true
          object = parse_object(scanner)
          break unless object
          list << object
        end
        scanner.scan(/e/) or raise BEncodeError, "Invalid list: missing closing e. #{scanner.pos}"

        list
      end

      # This method parases a bencoded dictionary.
      #
      #   scanner = StringScanner.new("de")
      #   BEncodr::Parser.parse_dictionary(scanner) #=> {}
      #
      # @param [StringScanner] scanner the scanner of a bencoded dictionary
      # @return [::Hash] the parsed hash
      def parse_dictionary(scanner)
        dictionary = {}

        scanner.scan(/d/) or raise BEncodeError, "Invalid dictionary: missing opening d. #{scanner.pos}"
        while true
          key_value = parse_key_value(scanner)
          break unless key_value
          dictionary.store(*key_value)
        end
        scanner.scan(/e/) or raise BEncodeError, "Invalid dictionary: missing closing e. #{scanner.pos}"

        dictionary
      end


      def parse_key_value(scanner) # :nodoc:
        key = parse_object(scanner)
        return key unless key
        raise BEncodeError, "Invalid dictionary: key is not a string. #{scanner.pos}" unless key.is_a?(::String)

        value = parse_object(scanner)
        raise BEncodeError, "Invalid dictionary: missing value for key (#{key}). #{scanner.pos}" unless value

        [key, value]
      end
      private :parse_key_value
    end
  end
end