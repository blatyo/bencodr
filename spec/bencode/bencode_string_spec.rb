require "spec"
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "String" do
  it "should encode to bencoding" do
    "string".bencode.should == "6:string"
  end

  it "should parse a bencoded string" do
    String.parse!("6:string").should == "string"
    String.parse("6:string").should == "string"
  end

  it "should raise error when valid length is not found while parsing!" do
    lambda { String.parse! "06:string" }.should raise_error(BEncode::BEncodeError)
    lambda { String.parse! "-6:string" }.should raise_error(BEncode::BEncodeError)
  end

  it "should raise error when encoded length is too long while parsing!" do
    lambda { String.parse! "7:string" }.should raise_error(BEncode::BEncodeError) 
  end

  it "should not raise an exception while parsing" do
    lambda { String.parse "06:string" }.should_not raise_error(BEncode::BEncodeError)
    lambda { String.parse "-6:string" }.should_not raise_error(BEncode::BEncodeError)
    lambda { String.parse "7:string" }.should_not raise_error(BEncode::BEncodeError) 
  end
end

describe "Symbol" do
  it "should encode to bencoding" do
    :symbol.bencode.should == "6:symbol"
  end
end

describe "URI" do
  it "should encode to bencoding" do
    uri = URI.parse("http://github.com/blatyo/bencode")
    uri.bencode.should == "32:http://github.com/blatyo/bencode"
  end
end
