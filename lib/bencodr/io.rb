# encoding: UTF-8

module BEncodr
  module IO
    module ClassMethods
      def bencode(fd, object)
        open(fd, "wb") {|file| file.bencode(object)}
      end
      
      def bdecode(fd)
        open(fd, "rb") {|file| file.bdecode}
      end
    end
    
    def bencode(object)
      write(Object.bencode(object))
    end
    
    def bdecode
      Object.bdecode(read.force_encoding('UTF-8'))
    end
    
    def self.included(base)
      base.extend ClassMethods
    end
  end
end