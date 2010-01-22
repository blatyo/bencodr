require "spec"
require "spec_helper"

describe String do
  describe "#bencode" do
    it "should encode a string" do
      "string".bencode.should == "6:string"
    end
  end
end

describe Symbol do
  describe "#bencode" do
    it "should encode a symbol" do
      :symbol.bencode.should == "6:symbol"
    end
  end
end

describe URI::Generic do
  describe "#bencode" do
    it "should encode a http uri" do
      uri = URI.parse("http://github.com/blatyo/bencode")
      uri.bencode.should == "32:http://github.com/blatyo/bencode"
    end

    it "should encode a https uri" do
      uri = URI.parse("https://github.com/blatyo/bencode")
      uri.bencode.should == "33:https://github.com/blatyo/bencode"
    end

    it "should encode a ftp uri" do
      uri = URI.parse("ftp://github.com/blatyo/bencode")
      uri.bencode.should == "31:ftp://github.com/blatyo/bencode"
    end

    it "should encode a ldap uri" do
      uri = URI.parse("ldap://github.com/blatyo/bencode")
      uri.bencode.should == "32:ldap://github.com/blatyo/bencode"
    end

    it "should encode a mailto uri" do
      uri = URI.parse("mailto:sudo@sudoers.su")
      uri.bencode.should == "22:mailto:sudo@sudoers.su"
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
