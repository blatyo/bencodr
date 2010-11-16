# encoding: UTF-8
require "spec_helper"

describe BEncodr::String do
  describe "#bencode" do
    it{ should bencode("string").to("6:string") }
    it{ should bencode("").to("0:") }
    it{ should bencode(:symbol).to("6:symbol") }
    it{ should bencode(URI.parse("http://github.com/blatyo/bencodr")).to("32:http://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("https://github.com/blatyo/bencodr")).to("33:https://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("ftp://github.com/blatyo/bencodr")).to("31:ftp://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("ldap://github.com/blatyo/bencodr")).to("32:ldap://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("mailto:sudo@sudoers.su")).to("22:mailto:sudo@sudoers.su") }
  end
end
