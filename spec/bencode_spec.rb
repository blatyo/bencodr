require "spec"

describe BEncode do
  describe "#parse_stirng" do
    it "should parse a bencoded string" do
      BEncode.parse_string(StringScanner.new("6:string")).should == "string"
    end

    it "should parse a zero length bencoded string" do
      BEncode.parse_string(StringScanner.new("0:")).should == ""
    end

    it "should raise an error if the length is invalid" do
      lambda {BEncode.parse_string(StringScanner.new("fail:"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if length is too long" do
      lambda {BEncode.parse_string(StringScanner.new("3:a"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if the colon is missing" do
      lambda {BEncode.parse_string(StringScanner.new("3aaa"))}.should raise_error BEncode::BEncodeError
    end
  end

  describe "#parse_integer" do
    it "should parse a bencoded integer" do
      BEncode.parse_integer(StringScanner.new("i4e")).should == 4
    end

    it "should raise an error if there is no starting i" do
      lambda{BEncode.parse_integer(StringScanner.new("4e"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if there is no integer" do
      lambda{BEncode.parse_integer(StringScanner.new("ie"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      lambda{BEncode.parse_integer(StringScanner.new("i"))}.should raise_error BEncode::BEncodeError
    end
  end

  describe "#parse_list" do
    it "should parse an empty bencoded list" do
      BEncode.parse_list(StringScanner.new("le")).should == []
    end

    it "should parse a bencoded list containing a string" do
      BEncode.parse_list(StringScanner.new("l6:stringeeeee")).should == ["string"]
    end

    it "should parse a bencoded list containing more than one string" do
      BEncode.parse_list(StringScanner.new("l6:string6:stringe")).should == ["string", "string"]
    end

    it "should parse a bencoded list containing an integer" do
      BEncode.parse_list(StringScanner.new("li1ee")).should == [1]
    end

    it "should parse a bencoded list containing more than one integer" do
      BEncode.parse_list(StringScanner.new("li1ei2ee")).should == [1, 2]
    end

    it "should parse a bencoded list containing a list" do
      BEncode.parse_list(StringScanner.new("llee")).should == [[]]
    end

    it "should parse a bencoded list containing more than one list" do
      BEncode.parse_list(StringScanner.new("llelee")).should == [[], []]
    end

    it "should parse a bencoded list containing a dictionary" do
      BEncode.parse_list(StringScanner.new("ldee")).should == [{}]
    end

    it "should parse a bencoded list containing more than one dictionary" do
      BEncode.parse_list(StringScanner.new("ldedee")).should == [{}, {}]
    end

    it "should raise an error if there is no starting l" do
      lambda{BEncode.parse_list(StringScanner.new("e"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      lambda{BEncode.parse_list(StringScanner.new("l"))}.should raise_error BEncode::BEncodeError
    end
  end

  describe "#parse_dictionary" do
    it "should parse an empty bencoded dictionary" do
      BEncode.parse_dictionary(StringScanner.new("de")).should == {}
    end

    it "should parse a bencoded dictionary containing a key value pair" do
      BEncode.parse_dictionary(StringScanner.new("d6:stringi1ee")).should == {"string" => 1}
    end

    it "should parse a bencoded dictionary containing more than one key value pair" do
      BEncode.parse_dictionary(StringScanner.new("d7:anotherle6:stringi1ee")).should == {"string" => 1, "another" => []}
    end

    it "should raise an error if there is no starting d" do
      lambda{BEncode.parse_dictionary(StringScanner.new("e"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if the key is not a string" do
      lambda{BEncode.parse_dictionary(StringScanner.new("di1ei1ee"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      lambda{BEncode.parse_dictionary(StringScanner.new("d"))}.should raise_error BEncode::BEncodeError
    end

    it "should raise an error if there is a key with no value" do
      lambda{BEncode.parse_dictionary(StringScanner.new("d1:ae"))}.should raise_error BEncode::BEncodeError
    end
  end
end