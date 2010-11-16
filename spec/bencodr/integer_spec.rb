# encoding: UTF-8
require "spec_helper"

describe BEncodr::Integer do
  describe "#bencodr" do
    it{ should bencode(1).to("i1e") }
    it{ should bencode(-1).to("i-1e") }
    it{ should bencode(10_000_000_000).to("i10000000000e") }
    it{ should bencode(-10_000_000_000).to("i-10000000000e") }
    it{ should bencode(1.1).to("i1e") }
    it{ should bencode(-1.1).to("i-1e") }
    it{ should bencode(1e10).to("i10000000000e") }
    it{ should bencode(-1e10).to("i-10000000000e") }
    it{ should bencode(Time.at(4)).to("i4e") }
  end
end