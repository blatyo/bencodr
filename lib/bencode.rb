path = File.expand_path(File.dirname(__FILE__)) + "/bencode"

require "#{path}/string"
require "#{path}/integer"
require "#{path}/list"
require "#{path}/dictionary"
require "#{path}/parser"

module BEncode
  class BEncodeError < StandardError; end
end