# encoding: UTF-8

require 'uri'

module BEncode
  module String
    module Generic
      module InstanceMethods
        # Encodes object into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        #   :symbol.bencode #=> "6:symbol"
        #
        # @return [::String] the bencoded string
        def bencode
          (respond_to?(:to_s) ? to_s : to_str).bencode
        end
      end
    end

    # Registers a class as an object that can be converted into a bencoded string. Class must have instance method to_s
    # or to_str.
    #
    #   class MyClass
    #     def to_s
    #       "string"
    #     end
    #   end
    #
    #   BEncode::String.register MyClass
    #   my_class = MyClass.new
    #   my_class.bencode  #=> "6:string"
    #
    # @param [Class#to_s, Class#to_str] type the class to add the bencode instance method to
    def self.register(type)
      type.send :include, Generic::InstanceMethods
    end

    register Symbol
    register URI::Generic

    module String
      module InstanceMethods
        # Encodes a string into a bencoded string. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string.
        #
        #   "string".bencode #=> "6:string"
        #
        # @return [::String] the bencoded string
        def bencode
          [length, ':', self].join
        end
      end

      ::String.send :include, InstanceMethods
    end
  end
end