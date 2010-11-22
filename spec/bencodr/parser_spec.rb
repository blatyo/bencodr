# encoding: UTF-8

require "spec_helper"

describe BEncodr::Parser do
  describe "#parse_object" do
    it{ should parse("6:string").as(:object).to("string") }
    it{ should parse("i4e").as(:object).to(4) }
    it{ should parse("l6:stringeeeee").as(:object).to(["string"]) }
    it{ should parse("d6:stringi1ee").as(:object).to({"string" => 1}) }
    it{ should parse("freak out!").as(:object).to(nil) }
  end

  describe "#parse_stirng" do
    it{ should parse("6:string").as(:string).to("string") }
    it{ should parse("0:").as(:string).to("") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:string).with("fail:") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:string).with("3:a") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:string).with("3aaa") }
  end

  describe "#parse_integer" do
    it{ should parse("i4e").as(:integer).to(4) }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:integer).with("4e") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:integer).with("ie") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:integer).with("i4") }
  end

  describe "#parse_list" do
    it{ should parse("le").as(:list).to([]) }
    it{ should parse("l6:stringeeeee").as(:list).to(["string"]) }
    it{ should parse("l6:string6:stringe").as(:list).to(["string", "string"]) }
    it{ should parse("li1ee").as(:list).to([1]) }
    it{ should parse("li1ei-2ee").as(:list).to([1, -2]) }
    it{ should parse("llee").as(:list).to([[]]) }
    it{ should parse("llelee").as(:list).to([[], []]) }
    it{ should parse("ldee").as(:list).to([{}]) }
    it{ should parse("ldedee").as(:list).to([{}, {}]) }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:list).with("e") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:list).with("l") }
  end

  describe "#parse_dictionary" do
    it{ should parse("de").as(:dictionary).to({}) }
    it{ should parse("d6:stringi1ee").as(:dictionary).to({"string" => 1}) }
    it{ should parse("d7:anotherle6:stringi1ee").as(:dictionary).to({"string" => 1, "another" => []}) }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:dictionary).with("e") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:dictionary).with("di1ei1ee") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:dictionary).with("d") }
    it{ should generate_parse_error(BEncodr::BEncodeError).for(:dictionary).with("d1:ae") }
  end
end

describe String do
  describe "#bdecode" do
    it{ "6:string".should bdecode_to("string") }
    it{ "i-1e".should bdecode_to(-1) }
    it{ "le".should bdecode_to([]) }
    it{ "de".should bdecode_to({}) }
  end
end