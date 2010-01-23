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

describe BEncode::Integer do
  describe "#register" do
    context "once an object has been registered as a BEncode integer" do
      before :all do
        BEncode::Integer.register NilClass
      end

      context "an instance of that object" do
        it "should respond to bencode" do
          nil.should respond_to :bencode
        end

        it "should encode to a bencoded integer" do
          nil.bencode.should == "i0e"
        end
      end
    end
  end
end