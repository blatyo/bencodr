# encoding: UTF-8

shared_examples_for "BEncodr::String" do |obj|
  subject{ obj }
  
  describe "#bencode" do
    it{ should bencode("string").to("6:string") }
    it{ should bencode("£").to("2:£") }
    it{ should bencode("").to("0:") }
    it{ should bencode(:symbol).to("6:symbol") }
    it{ should bencode(URI.parse("http://github.com/blatyo/bencodr")).to("32:http://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("https://github.com/blatyo/bencodr")).to("33:https://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("ftp://github.com/blatyo/bencodr")).to("31:ftp://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("ldap://github.com/blatyo/bencodr")).to("32:ldap://github.com/blatyo/bencodr") }
    it{ should bencode(URI.parse("mailto:sudo@sudoers.su")).to("22:mailto:sudo@sudoers.su") }
  end
end

shared_examples_for "BEncodr::Integer" do |obj|
  subject{ obj }
  
  describe "#bencode" do
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

shared_examples_for "BEncodr::List" do |obj|
  subject{ obj }
  
  describe "#bencode" do
    it{ should bencode([]).to("le") }
    it{ should bencode([:e, "a", 1, Time.at(11)]).to("l1:e1:ai1ei11ee") }
  end
end

shared_examples_for "BEncodr::Dictionary" do |obj|
  subject{ obj }
  
  describe "#bencode" do
    it{ should bencode({}).to("de") }
    it{ should bencode({:a => 1, "A" => 1, 1=> 1}).to("d1:1i1e1:Ai1e1:ai1ee")}

    context "a key should always be encoded as a string" do
      it{ should bencode({"string" => "string"}).to("d6:string6:stringe") }
      it{ should bencode({:symbol => :symbol}).to("d6:symbol6:symbole") }
      it{ should bencode({1 => 1}).to("d1:1i1ee")}
      it{ should bencode({1.1 => 1.1}).to("d3:1.1i1ee") }
      
      describe "ruby 1.9.x", :if => $ruby19 do
        it{ should bencode({{} => {}}).to("d2:{}dee") }

        it{
          time = Time.utc(0)
          should bencode({time => time}).to("d23:0000-01-01 00:00:00 UTCi-62167219200ee")
        }

        it{
          array = (1..4).to_a
          should bencode({array => array}).to("d12:[1, 2, 3, 4]li1ei2ei3ei4eee")
        }
      end

      describe "ruby 1.8.x", :unless => $ruby19 do
        it{ should bencode({{} => {}}).to("d0:dee") }

        it{
          time = Time.utc(0)
          should bencode({time => time}).to("d28:Sat Jan 01 00:00:00 UTC 2000i946684800ee")
        }

        it{
          array = (1..4).to_a
          should bencode({array => array}).to("d4:1234li1ei2ei3ei4eee")
        }
      end

      it{
        uri = URI.parse("http://github.com/blatyo/bencode")
        should bencode({uri => uri}).to("d32:http://github.com/blatyo/bencode32:http://github.com/blatyo/bencodee")
      }
    end
  end
end

shared_examples_for "BEncode decoder" do |klass|
  subject{ klass }
  
  it{ should bdecode("6:string").to("string") }
  it{ should bdecode("0:").to("") }
  it{ should bdecode("6:symbol").to("symbol") }
  it{ should bdecode("32:http://github.com/blatyo/bencodr").to("http://github.com/blatyo/bencodr") }
  it{ should bdecode("33:https://github.com/blatyo/bencodr").to("https://github.com/blatyo/bencodr") }
  it{ should bdecode("31:ftp://github.com/blatyo/bencodr").to("ftp://github.com/blatyo/bencodr") }
  it{ should bdecode("32:ldap://github.com/blatyo/bencodr").to("ldap://github.com/blatyo/bencodr") }
  it{ should bdecode("22:mailto:sudo@sudoers.su").to("mailto:sudo@sudoers.su") }
end

shared_examples_for "a BEncodr extension" do |obj, klass|
  subject{ obj }
  
  it{ should respond_to(:bencode) }
  it{ should be_a(klass) }
end