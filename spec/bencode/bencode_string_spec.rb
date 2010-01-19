require "spec"
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "String" do
  it "should encode to bencoding" do
    "string".bencode.should == "6:string"
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
