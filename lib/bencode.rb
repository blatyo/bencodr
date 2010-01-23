path = File.expand_path(File.dirname(__FILE__)) + "/bencode"

module BEncode
  class BEncodeError < StandardError; end
end

require "#{path}/string"
require "#{path}/integer"
require "#{path}/list"
require "#{path}/dictionary"