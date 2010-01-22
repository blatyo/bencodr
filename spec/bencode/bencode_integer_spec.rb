require "spec"
require "spec_helper"

describe Integer do
  describe "#bencode" do
    it "should encode a positive integer" do
      1.bencode.should == "i1e"
    end

    it "should encode a negative integer" do
      -1.bencode.should == "i-1e"
    end

    it "should encode a positive big integer" do
      10_000_000_000.bencode.should == "i10000000000e"
    end

    it "should encode a negative big integer" do
      -10_000_000_000.bencode.should == "i-10000000000e"
    end
  end
end

describe Numeric do
  describe "#bencode" do
    it "should encode a positive float with precision loss" do
      1.1.bencode.should == "i1e"
    end

    it "should encode a negative float with precision loss" do
      -1.1.bencode.should == "i-1e"
    end

    it "should encode an positive exponential float" do
      1e10.bencode.should == "i10000000000e"
    end

    it "should encode an negative exponential float" do
      -1e10.bencode.should == "i-10000000000e"
    end
  end
end

describe Time do
  describe "#bencode" do
    it "should encode to bencoding" do
      Time.at(4).bencode.should == "i4e"
    end
  end
end

describe "Generic object that can convert to integer" do
  before :all do
    klass = Class.new do
      def to_i
        1
      end
    end
    BEncode::Integer.register klass
    @instance = klass.new
  end

  it "should be able to register as a bencodable integer" do
    @instance.respond_to?(:bencode).should == true
  end

  it "should encode to bencoding" do
    @instance.bencode.should == "i1e"
  end
end