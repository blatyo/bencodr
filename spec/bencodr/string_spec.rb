# encoding: UTF-8

require "spec"
require "spec_helper"

describe BEncodr::String do
  describe "#bencode" do
    it "should encode a string" do
      BEncodr::String.bencode("string").should == "6:string"
    end

    it "should encode a zero length string" do
      BEncodr::String.bencode("").should == "0:"
    end
    
    it "should encode a symbol" do
      BEncodr::String.bencode(:symbol).should == "6:symbol"
    end
    
    it "should encode a http uri" do
      uri = URI.parse("http://github.com/blatyo/bencodr")
      BEncodr::String.bencode(uri).should == "32:http://github.com/blatyo/bencodr"
    end

    it "should encode a https uri" do
      uri = URI.parse("https://github.com/blatyo/bencodr")
      BEncodr::String.bencode(uri).should == "33:https://github.com/blatyo/bencodr"
    end

    it "should encode a ftp uri" do
      uri = URI.parse("ftp://github.com/blatyo/bencodr")
      BEncodr::String.bencode(uri).should == "31:ftp://github.com/blatyo/bencodr"
    end

    it "should encode a ldap uri" do
      uri = URI.parse("ldap://github.com/blatyo/bencodr")
      BEncodr::String.bencode(uri).should == "32:ldap://github.com/blatyo/bencodr"
    end

    it "should encode a mailto uri" do
      uri = URI.parse("mailto:sudo@sudoers.su")
      BEncodr::String.bencode(uri).should == "22:mailto:sudo@sudoers.su"
    end
  end
end
