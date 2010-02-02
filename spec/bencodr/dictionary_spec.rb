# encoding: UTF-8

require "spec"
require "spec_helper"

describe Hash do
  describe "#bencodr" do
    it "should encode an empty hash" do
      {}.bencode.should == "de"
    end

    context "a key should always be encoded as a string" do
      it "should encode a string key as a string" do
        {"string" => "string"}.bencode.should == "d6:string6:stringe"
      end

      it "should encode a symbol key as a string" do
        {:symbol => :symbol}.bencode.should == "d6:symbol6:symbole"
      end

      it "should encode a uri key as a string" do
        uri = URI.parse("http://github.com/blatyo/bencode")
        {uri => uri}.bencode.should == "d32:http://github.com/blatyo/bencode32:http://github.com/blatyo/bencodee"
      end

      it "should encode an integer key as a string" do
        {1 => 1}.bencode.should == "d1:1i1ee"
      end

      it "should encode a float key as a string" do
        {1.1 => 1.1}.bencode.should == "d3:1.1i1ee"
      end

      it "should encode a time key as a string" do
        time = Time.utc(0)
        {time => time}.bencode.should == "d23:2000-01-01 00:00:00 UTCi946684800ee"
      end

      it "should encode an array key as a string" do
        array = (1..4).to_a
        {array => array}.bencode.should == "d12:[1, 2, 3, 4]li1ei2ei3ei4eee"
      end

      it "should encode a hash key as a string" do
        {{} => {}}.bencode.should == "d2:{}dee"
      end
    end

    it "should encode keys in sorted (as raw strings) order" do
      {:a => 1, "A" => 1, 1=> 1}.bencode.should == "d1:1i1e1:Ai1e1:ai1ee"
    end
  end
end

describe BEncodr::Dictionary do
  describe "#register" do
    context "once an object has been registered as a BEncode dictionary" do
      before :all do
        klass = Class.new do
          def to_h
            {:a => "a", :b => "b"}
          end
        end
        BEncodr::Dictionary.register klass
        @instance = klass.new
      end

      context "an instance of that object" do
        it "should respond to bencodr" do
          @instance.should respond_to :bencode
        end

        it "should encode to a bencoded dictionary" do
          @instance.bencode.should == "d1:a1:a1:b1:be"
        end
      end
    end
  end
end