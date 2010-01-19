require 'uri'

module BEncode
  module String
    module String
      module ClassMethods

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

    module Symbol
      module InstanceMethods
        # Encodes a symbol into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        # :symbol.bencode #=> "6:symbol"
        def bencode
          to_s.bencode
        end
      end

      ::Symbol.class_eval {include InstanceMethods}
    end

    module URIGeneric
      module InstanceMethods
        # Encodes a uri into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        # uri = URI.parse("http://github.com/blatyo/bencode")
        # uri.bencode #=> "32:http://github.com/blatyo/bencode"
        def bencode
          to_s.bencode
        end
      end

      ::URI::Generic.class_eval {include InstanceMethods}
    end
  end
end