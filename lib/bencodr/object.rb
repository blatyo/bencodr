module BEncodr
  module Object
    def self.bencode(object)
      return object.bencode if object.respond_to?(:bencode)
      
      case object
      when ::String, Symbol, URI::Generic
        return String.bencode(object)
      when Numeric, Time
        return Integer.bencode(object)
      when Array
        return List.bencode(object)
      when Hash
        return Dictionary.bencode(object)
      else
        [String, Integer, List, Dictionary].each do |type|
          begin
            return type.bencode(object)
          rescue
          end
        end
      end
      
      raise BEncodeError, "BEncodr::Object.bencode was unable to infer the type of the object passed in."
    end
    
    def self.bdecode(string)
      object = Parser.parse_object(StringScanner.new(string))
      object or raise BEncodeError, "BEncodr::Object.bdecode was unable to parse the string passed in."
    end
    
    def bdecode
      Object.bdecode(self)
    end
  end
end