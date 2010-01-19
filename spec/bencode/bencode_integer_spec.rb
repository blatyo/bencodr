require "spec"
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Integer" do
  it "should encode to bencoding" do
    1.bencode.should == "i1e"
    -1.bencode.should == "i-1e"
  end

   it "should parse a bencoded integer" do
    Integer.parse!("i6e").should == 6
    Integer.parse!("i-6e").should == -6
    Integer.parse("i6e").should == 6
    Integer.parse("i-6e").should == -6
  end

  it "should raise error when valid integer is not found while parsing!" do
    lambda { Integer.parse! "not an integer" }.should raise_error(BEncode::BEncodeError)
    lambda { Integer.parse! "01" }.should raise_error(BEncode::BEncodeError)
  end

  it "should not raise an exception while parsing" do
    lambda { Integer.parse "not an integer" }.should_not raise_error(BEncode::BEncodeError)
    lambda { Integer.parse "01" }.should_not raise_error(BEncode::BEncodeError)
  end
end

describe "Numeric" do
  it "should encode to bencoding" do
    1.1.bencode.should == "i1e"
    -3.4e2.bencode.should == "i-340e"
  end
end

describe "Time" do
  it "should encode to bencoding" do
    Time.at(4).bencode.should == "i4e"
  end
end