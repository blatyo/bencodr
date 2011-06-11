# encoding: UTF-8

path = File.expand_path(File.dirname(__FILE__)) + "/bencodr/"

require path + "string"
require path + "integer"
require path + "list"
require path + "dictionary"
require path + "object"
require path + "parser"
require path + "io"
require path + "ext"
require path + "version"

module BEncodr
  class BEncodeError < StandardError; end

  class << self
    def bdecode(object)
      BEncodr::Object.bdecode(object)
    end

    def bdecode_file(fd)
      ::File.open(fd, "rb") {|file| bdecode(file.read)}
    end

    def bencode(object)
      BEncodr::Object.bencode(object)
    end

    def bencode_file(fd, object)
      ::File.open(fd, "wb") {|file| file.write(bencode(object))}
    end

    def include!
      Ext.include!
    end
  end
end
