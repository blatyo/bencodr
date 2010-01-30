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
    def parse(string)
      scanner = StringScanner.new(string)
      Parser.parse_object(scanner) or raise BEncodeError, "Invalid bencoding"
    end

    def parse_file(file)
      parse(File.open(file, 'rb').read)
    end
  end
end