module BEncodr
  module Object
    def self.bencode(object)
      return object.bencode if object.respond_to?(bencode)
      
      [String, Integer, List, Dictionary].each do |type|
        begin
          return type.bencode(object)
        rescue
        end
      end
      
      raise BEncodeError, "BEncodr.encode was unable to infer the type for the object passed in."
    end
    
    def self.bdecode(object)
      Parser.parse_object(StringScanner.new(string))
    end
  end
end