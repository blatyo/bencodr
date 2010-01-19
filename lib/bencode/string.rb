require 'uri'

module BEncode
  module String
    module Generic
      module InstanceMethods
        # Encodes object into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        # :symbol.bencode #=> "6:symbol"
        def bencode
          (respond_to?(:to_s) ? to_s : to_str).bencode
        end
      end
    end

    # Registers a class as an object that can be converted into a bencoded string. Class must have instance method to_s
    # or to_str.
    #
    # class MyClass
    #   def to_s
    #     "string"
    #   end
    # end
    #
    # BEncode::String.register MyClass
    # my_class = MyClass.new
    # my_class.bencode  #=> "6:string"
    def self.register(type)
      type.class_eval {include Generic::InstanceMethods}
    end

    register Symbol
    register URI::Generic

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
  end
end