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
    # This method decodes a bencoded string.
    #
    #   BEncode.decode("6:string") #=> "string"
    #
    # @param [::String] string the bencoded string to decode
    # @return [::String, ::Integer, ::Hash, ::Array] the decoded object
    def decode(string)
      string.bdecode
    end

    # This method decodes a bencoded file.
    #
    #   BEncode.decode_file("simple.torrent") #=> "d8:announce32:http://www..."
    #
    # @param [::String] file the file to decode
    # @return [::String, ::Integer, ::Hash, ::Array] the decoded object
    def decode_file(name)
      File.bdecode name
    end

    # This method encodes a bencoded object.
    #
    #   BEncode.encode("string") #=> "6:string"
    #
    # @param [#bencodr] object the object to encode
    # @return [::String] the bencoded object
    def encode(object)
      object.bencode
    end

    # This method encodes a bencoded object.
    #
    #   BEncode.encode("string") #=> "6:string"
    #
    # @param [::String] file the file to write the bencoded object to
    # @param [#bencodr] object the object to encode
    def encode_file(name, object)
      File.bencode name, object
    end
  end
end