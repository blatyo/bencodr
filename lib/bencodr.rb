# encoding: UTF-8

path = File.expand_path(File.dirname(__FILE__)) + "/bencodr/"

require path + "string"
require path + "integer"
require path + "list"
require path + "dictionary"
require path + "parser"
require path + "io"

module BEncodr
  class BEncodeError < StandardError; end

  class << self
    def decode(object)
      BEncodr::Object.bdecode(object)
    end

    def decode_file(name)
      ::IO.open(name, "rb") {|file| decode(file.read)}
    end

    def encode(object)
      BEncodr::Object.bencode(object)
    end

    def encode_file(name, object)
      ::IO.open(name, "wb") {|file| file.write(encode(object))}
    end
    
    def include!
      Ext.include!
    end
  end
end