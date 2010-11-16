# encoding: UTF-8
require "spec_helper"

describe BEncodr::List do
  describe "#bencode" do
    it "should encode an empty array" do
      BEncodr::List.bencode([]).should == "le"
    end

    it "should encode an array filled with bencodable objects" do
      BEncodr::List.bencode([:e, "a", 1, Time.at(11)]).should == "l1:e1:ai1ei11ee"
    end
  end
end