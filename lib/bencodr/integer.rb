# encoding: UTF-8

module BEncodr
  module Integer
    def bencode
      Integer.bencode(self)
    end
    
    def self.bencode(intable)
      int = coerce(intable)
      
      [:i, int, :e].join
    end
    
    private
    
    def self.coerce(intable)
      if intable.respond_to?(:to_i)
        intable.to_i
      elsif intable.respond_to?(:to_int)
        intable.to_int
      else
        raise BEncodeError, "BEncodr::Integer.bencode can only be called on an object that provides a to_i or to_int method."
      end
    end
  end
end