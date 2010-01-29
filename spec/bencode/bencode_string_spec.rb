require "spec"
require "spec_helper"

describe String do
  describe "#bencode" do
    it "should encode a string" do
      "string".bencode.should == "6:string"
    end

    it "should encode a zero length string" do
      "".bencode.should == "0:"
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

describe BEncode::String do
  describe "#register" do
    context "once an object has been registered as a BEncode string" do
      before :all do
        BEncode::String.register Range
      end

      context "an instance of that object" do
        it "should respond to bencode" do
          (1..2).should respond_to :bencode
        end

        it "should encode to a bencoded string" do
          (1..2).bencode.should == "4:1..2"
        end
      end
    end
  end
end
