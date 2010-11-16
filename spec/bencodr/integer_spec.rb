# encoding: UTF-8
require "spec_helper"

describe BEncodr::Integer do
  describe "#bencodr" do
    it "should encode a positive integer" do
      BEncodr::Integer.bencode(1).should == "i1e"
    end

    it "should encode a negative integer" do
      BEncodr::Integer.bencode(-1).should == "i-1e"
    end

    it "should encode a positive big integer" do
      BEncodr::Integer.bencode(10_000_000_000).should == "i10000000000e"
    end

    it "should encode a negative big integer" do
      BEncodr::Integer.bencode(-10_000_000_000).should == "i-10000000000e"
    end
    
    it "should encode a positive float with precision loss" do
      BEncodr::Integer.bencode(1.1).should == "i1e"
    end

    it "should encode a negative float with precision loss" do
      BEncodr::Integer.bencode(-1.1).should == "i-1e"
    end

    it "should encode an positive exponential float" do
      BEncodr::Integer.bencode(1e10).should == "i10000000000e"
    end

    it "should encode an negative exponential float" do
      BEncodr::Integer.bencode(-1e10).should == "i-10000000000e"
    end
    
    it "should encode a time" do
      BEncodr::Integer.bencode(Time.at(4)).should == "i4e"
    end
  end
end