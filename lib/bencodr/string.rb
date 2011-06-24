# encoding: UTF-8

require 'uri'

module BEncodr
  module String
    def bencode
      String.bencode(self)
    end
    
    def self.bencode(stringable)
      string = coerce(stringable)
      
      [string.bytesize, ':', string].join
    end
    
    private
    
    def self.coerce(stringable)
      if stringable.respond_to?(:to_s)
        stringable.to_s
      elsif stringable.respond_to?(:to_str)
        stringable.to_str
      else
        raise BEncodeError, "BEncodr::String.bencode can only be called on an object that provides a to_s or to_str method."
      end
    end
  end
end