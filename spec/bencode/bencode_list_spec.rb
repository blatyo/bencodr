require "spec"
require "spec_helper"

describe Array do
  describe "#bencode" do
    it "should encode an empty array" do
      [].bencode.should == "le"
    end

    it "should encode an array filled with bencodable objects" do
      [:e, "a", 1, Time.at(11)].bencode.should == "l1:e1:ai1ei11ee"
    end
  end
end

describe BEncode::List do
  describe "#register" do
    context "once an object has been registered as a BEncode list" do
      before :all do
        BEncode::List.register Range
      end

      context "an instance of that object" do
        it "should respond to bencode" do
          (1..2).should respond_to :bencode
        end

        it "should encode to a bencoded list" do
          (1..2).bencode.should == "li1ei2ee"
        end
      end
    end
  end
end