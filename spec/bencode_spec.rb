# encoding: UTF-8

require "spec"
require "spec_helper"

describe BEncodr do
  describe "#decode" do
    # Most of this is covered in other tests. Only difference is this accepts string instead of scanner.
    it "should parse a bencoded string" do
      BEncodr.decode("6:string").should == "string"
    end

    it "should parse a bencoded integer" do
      BEncodr.decode("i4e").should == 4
    end

    it "should parse a bencoded list" do
      BEncodr.decode("l6:stringeeeee").should == ["string"]
    end

    it "should parse a bencoded dictionary containing a key value pair" do
      BEncodr.decode("d6:stringi1ee").should == {"string" => 1}
    end

    it "should raise an error when the type is not recognized" do
      lambda{BEncodr.decode("freak out!")}.should raise_error BEncodr::BEncodeError
    end
  end

  describe "#decode_file" do
    it "should parse a bencoded file" do
      dirname = File.dirname(__FILE__)
      BEncodr.decode_file("#{dirname}/samples/mini.bencode").should == {"ba" => 3}
    end
  end

  describe "#encode" do
    # Covered in other tests so only simple stuff here. 
    it "should bencodr an object" do
      BEncodr.encode("string").should == "6:string"
    end
  end

  describe "#encode_file" do
    context "when an object gets bencoded and written to a file" do
      before :all do
        @path = File.join(File.dirname(__FILE__), '..', 'tmp')
        Dir.mkdir(@path) unless File.exists? @path
      end

      before :each do
        @file = File.join(@path, 'test.bencodr')
        @object = "string"
        BEncodr.encode_file(@file, @object)
      end

      it "should actually write a file" do
        File.exists?(@file).should be_true
      end

      it "should properly encode the file" do
        BEncodr.decode_file(@file).should == @object
      end

      after :each do
        File.delete(@file)
      end

      after :all do
        Dir.delete(@path) if File.exists? @path
      end
    end

    it "should read a torrent with newlines as part of a string without raising an error" do
      file = File.join(File.dirname(__FILE__), 'samples', 'python.torrent')
      lambda{BEncodr.decode_file file}.should_not raise_error
    end
  end

  context "when parsing and then encoding" do
    it "should be equal to the pre-parsed and encoded bencoded string" do
      file = File.dirname(__FILE__) + "/samples/bencode.rb.torrent"
      BEncodr.decode_file(file).bencode.should == File.open(file, "rb") {|f| f.read}
    end
  end
end