# encoding: UTF-8

require "spec"
require "spec_helper"

describe BEncodr::Dictionary do
  describe "#bencode" do
    it "should encode an empty hash" do
      BEncodr::Dictionary.bencode({}).should == "de"
    end

    context "a key should always be encoded as a string" do
      it "should encode a string key as a string" do
        BEncodr::Dictionary.bencode({"string" => "string"}).should == "d6:string6:stringe"
      end

      it "should encode a symbol key as a string" do
        BEncodr::Dictionary.bencode({:symbol => :symbol}).should == "d6:symbol6:symbole"
      end

      it "should encode a uri key as a string" do
        uri = URI.parse("http://github.com/blatyo/bencode")
        BEncodr::Dictionary.bencode({uri => uri}).should == "d32:http://github.com/blatyo/bencode32:http://github.com/blatyo/bencodee"
      end

      it "should encode an integer key as a string" do
        BEncodr::Dictionary.bencode({1 => 1}).should == "d1:1i1ee"
      end

      it "should encode a float key as a string" do
        BEncodr::Dictionary.bencode({1.1 => 1.1}).should == "d3:1.1i1ee"
      end

      it "should encode a time key as a string" do
        time = Time.utc(0)
        BEncodr::Dictionary.bencode({time => time}).should == "d23:0000-01-01 00:00:00 UTC23:0000-01-01 00:00:00 UTCe"
      end

      it "should encode an array key as a string" do
        array = (1..4).to_a
        BEncodr::Dictionary.bencode({array => array}).should == "d12:[1, 2, 3, 4]li1ei2ei3ei4eee"
      end

      it "should encode a hash key as a string" do
        BEncodr::Dictionary.bencode({{} => {}}).should == "d2:{}dee"
      end
    end

    it "should encode keys in sorted (as raw strings) order" do
      BEncodr::Dictionary.bencode({:a => 1, "A" => 1, 1=> 1}).should == "d1:1i1e1:Ai1e1:ai1ee"
    end
  end
end