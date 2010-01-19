require 'uri'

module BEncode
  module String
    module String
      module ClassMethods
        def parse!(string)
          match = string.match(/^([1-9]\d*|0):/)
          raise BEncode::BEncodeError, "Invalid bencoded string #{string}: invalid length." unless match
          length = match[1].to_i
          match = string.match(/^\d+:(.{#{length}})/)
          raise BEncode::BEncodeError, "Invalid bencoded string #{string}: encoded length #{length} too large." unless match
          match[1]
        end

        def parse(string)
          parse!(string)
        rescue
          nil
        end
      end

      module InstanceMethods
        # Encodes a string into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        # "string".bencode #=> "6:string"
        def bencode
          [length, ':', self].join
        end
      end

      ::String.extend ClassMethods
      ::String.class_eval {include InstanceMethods}
    end

    module Generic
      module InstanceMethods
        # Encodes object into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        # :symbol.bencode #=> "6:symbol"
        def bencode
          to_s.bencode
        end
      end
    end

    def self.register(type)
      type.class_eval {include Generic::InstanceMethods}
    end

    register Symbol
    register URI::Generic
  end
end