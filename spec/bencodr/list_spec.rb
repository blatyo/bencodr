# encoding: UTF-8
require "spec_helper"

describe BEncodr::List do
  describe "#bencode" do
    it{ should bencode([]).to("le") }
    it{ should bencode([:e, "a", 1, Time.at(11)]).to("l1:e1:ai1ei11ee")
  end
end