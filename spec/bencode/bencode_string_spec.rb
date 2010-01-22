require "spec"
require "spec_helper"

describe String do
  describe "#bencode" do
    it "should encode to bencoding" do
      "string".bencode.should == "6:string"
    end
  end
end

describe Symbol do
  describe "#bencode" do
    it "should encode to bencoding" do
      :symbol.bencode.should == "6:symbol"
    end
  end
end

describe URI::Generic do
  describe "#bencode" do
    it "should encode to bencoding" do
      uri = URI.parse("http://github.com/blatyo/bencode")
      uri.bencode.should == "32:http://github.com/blatyo/bencode"
    end
  end
end

describe "Generic object" do
  before :all do
    klass = Class.new do
      def to_s
        "string"
      end
    end
    BEncode::String.register klass
    @instance = klass.new
  end


  it "should be able to register as a bencodable string" do
    @instance.respond_to?(:bencode).should == true
  end

  it "should encode to bencoding" do
    @instance.bencode.should == "6:string"
  end
end
