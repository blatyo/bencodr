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

    def encode(object)
      object.bencode if object.respond_to?(bencode)
      
      [String, Integer, List, Dictionary].each do |type|
        begin
          return type.bencode(object)
        rescue
        end
      end
      
      raise BEncodeError, "BEncodr.encode was unable to infer the type for the object passed in."
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