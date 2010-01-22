require "spec"
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Array do
  describe "#bencode" do
    it "should encode to bencoding" do
      [].bencode.should == "le"
      [:e, "a", 1, Time.at(11)].bencode.should == "l1:e1:ai1ei11ee"
    end
  end
end

describe "Generic object that can convert to array" do
  before :all do
    BEncode::List.register Range
  end

  it "should be able to register as a bencodable list" do
    (1..2).respond_to?(:bencode).should == true
  end

  it "should encode to bencoding" do
    (1..2).bencode.should == "li1ei2ee"
  end
end