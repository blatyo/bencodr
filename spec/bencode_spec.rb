# encoding: UTF-8

require "spec"
require "spec_helper"

describe BEncode do
  describe "#parse" do
    # Most of this is covered in other tests. Only difference is this accepts string instead of scanner.
    it "should parse a bencoded string" do
      BEncode.parse("6:string").should == "string"
    end

    it "should parse a bencoded integer" do
      BEncode.parse("i4e").should == 4
    end

    it "should parse a bencoded list" do
      BEncode.parse("l6:stringeeeee").should == ["string"]
    end

    it "should parse a bencoded dictionary containing a key value pair" do
      BEncode.parse("d6:stringi1ee").should == {"string" => 1}
    end

    it "should raise an error when the type is not recognized" do
      lambda{BEncode.parse("freak out!")}.should raise_error BEncode::BEncodeError
    end
  end

  describe "#parse_file" do
    it "should parse a bencoded file" do
      dirname = File.dirname(__FILE__)
      BEncode.parse_file("#{dirname}/samples/mini.bencode").should == {"ba" => 3}
    end
  end

  context "when parsing and then encoding" do
    it "should be equal to the pre-parsed and encoded bencoded string" do
      file = File.dirname(__FILE__) + "/samples/bencode.rb.torrent"
      BEncode.parse_file(file).bencode.should == File.open(file, "rb").read
    end
  end
end