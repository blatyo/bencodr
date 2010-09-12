# encoding: UTF-8

module BEncodr
  module List
    def bencode
      List.bencode(self)
    end
    
    def self.bencode(arrayable)
      ary = coerce(arrayable)
      
      ary.collect do |element|
        Object.bencode(element)
      end.unshift(:l).push(:e).join
    end
    
    private
    
    def self.coerce(arrayable)
      if arrayable.respond_to?(:to_a)
        arrayable.to_a
      elsif arrayable.respond_to?(:to_ary)
        arrayable.to_ary
      else
        raise BEncodeError, "BEncodr::List.bencode can only be called on an object that provides a to_a or to_ary method."
      end
    end
  end
end