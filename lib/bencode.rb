# encoding: UTF-8

path = File.expand_path(File.dirname(__FILE__)) + "/bencode"

require path + "/string"
require path + "/integer"
require path + "/list"
require path + "/dictionary"
require path + "/parser"

module BEncode
  class BEncodeError < StandardError; end

  class << self
    def decode(string)
      scanner = StringScanner.new(string)
      Parser.parse_object(scanner) or raise BEncodeError, "Invalid bencoding"
    end

    def decode_file(file)
      decode(File.open(file, 'rb') {|f| f.read})
    end

    def encode(object)
      object.bencode
    end

    def encode_file(file, object)
      File.open(file, 'wb') {|f| f.write encode(object)}
    end
  end
end