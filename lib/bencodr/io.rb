module BEncodr
  module IO
    module ClassMethods
      def bencode(fd, object)
        BEncodr.encode_file(fd, object)
      end
      
      def bdecode(fd)
        BEncodr.decode_file(fd)
      end
    end
    
    def bencode(object)
      write(Object.bencode(object))
    end
    
    def bdecode
      Object.bdecode(read)
    end
    
    def self.included(base)
      base.extend ClassMethods
    end
  end
end