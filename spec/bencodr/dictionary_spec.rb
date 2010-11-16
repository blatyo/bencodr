# encoding: UTF-8
require "spec_helper"

describe BEncodr::Dictionary do
  describe "#bencode" do
    it{ should bencode({}).to("de") }
    it{ should bencode({:a => 1, "A" => 1, 1=> 1}).to("d1:1i1e1:Ai1e1:ai1ee")}

    context "a key should always be encoded as a string" do
      it{ should bencode({"string" => "string"}).to("d6:string6:stringe") }
      it{ should bencode({:symbol => :symbol}).to("d6:symbol6:symbole") }
      it{ should bencode({1 => 1}).to("d1:1i1ee")}
      it{ should bencode({1.1 => 1.1}).to("d3:1.1i1ee") }
      it{ should bencode({{} => {}}).to("d2:{}dee") }
      
      it{
        uri = URI.parse("http://github.com/blatyo/bencode")
        should bencode({uri => uri}).to("d32:http://github.com/blatyo/bencode32:http://github.com/blatyo/bencodee")
      }

      it{
        time = Time.utc(0)
        should bencode({time => time}).to("d23:0000-01-01 00:00:00 UTCi-62167219200ee")
      }

      it{
        array = (1..4).to_a
        should bencode({array => array}).to("d12:[1, 2, 3, 4]li1ei2ei3ei4eee")
      }
    end
  end
end