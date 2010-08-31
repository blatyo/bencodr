# encoding: UTF-8

module BEncodr
  module Dictionary
    def bencode
      Dictionary.bencode(self)
    end
    
    def self.bencode(hashable)
      hash = coerce(hashable)
      
      hash.keys.sort{|a, b| a.to_s <=> b.to_s}.collect do |key|
        BEncodr::String.bencode(key.to_s) + BEncodr.bencode(hash[key])
      end.unshift(:d).push(:e).join
    end
    
    private
    
    def self.coerce(hashable)
      if hashable.respond_to?(:to_h)
        hashable.to_h
      elsif hashable.respond_to?(:to_hash)
        hashable.to_hash
      else
        raise BEncodeError, "BEncodr::Dictionary.bencode can only be called on an object that provides a to_h or to_hash method."
      end
    end
  end
end