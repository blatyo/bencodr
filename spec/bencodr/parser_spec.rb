# encoding: UTF-8

require "spec"

describe BEncodr::Parser do
  describe "#parse_object" do
    # Most of this functionality is covered with other tests. So minimal stuff here.
    it "should parse a bencoded string" do
      scanner = StringScanner.new("6:string")
      BEncodr::Parser.parse_object(scanner).should == "string"
    end

    it "should parse a bencoded integer" do
      scanner = StringScanner.new("i4e")
      BEncodr::Parser.parse_object(scanner).should == 4
    end

    it "should parse a bencoded list" do
      scanner = StringScanner.new("l6:stringeeeee")
      BEncodr::Parser.parse_object(scanner).should == ["string"]
    end

    it "should parse a bencoded dictionary containing a key value pair" do
      scanner = StringScanner.new("d6:stringi1ee")
      BEncodr::Parser.parse_object(scanner).should == {"string" => 1}
    end

    it "should return nil when the type is not recognized" do
      scanner = StringScanner.new("freak out!")
      BEncodr::Parser.parse_object(scanner).should == nil
    end
  end

  describe "#parse_stirng" do
    it "should parse a bencoded string" do
      scanner = StringScanner.new("6:string")
      BEncodr::Parser.parse_string(scanner).should == "string"
    end

    it "should parse a zero length bencoded string" do
      scanner = StringScanner.new("0:")
      BEncodr::Parser.parse_string(scanner).should == ""
    end

    it "should raise an error if the length is invalid" do
      scanner = StringScanner.new("fail:")
      lambda {BEncodr::Parser.parse_string(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if length is too long" do
      scanner = StringScanner.new("3:a")
      lambda {BEncodr::Parser.parse_string(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if the colon is missing" do
      scanner = StringScanner.new("3aaa")
      lambda {BEncodr::Parser.parse_string(scanner)}.should raise_error BEncodr::BEncodeError
    end
  end

  describe "#parse_integer" do
    it "should parse a bencoded integer" do
      scanner = StringScanner.new("i4e")
      BEncodr::Parser.parse_integer(scanner).should == 4
    end

    it "should raise an error if there is no starting i" do
      scanner = StringScanner.new("4e")
      lambda{BEncodr::Parser.parse_integer(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if there is no integer" do
      scanner = StringScanner.new("ie")
      lambda{BEncodr::Parser.parse_integer(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      scanner = StringScanner.new("i4")
      lambda{BEncodr::Parser.parse_integer(scanner)}.should raise_error BEncodr::BEncodeError
    end
  end

  describe "#parse_list" do
    it "should parse an empty bencoded list" do
      scanner = StringScanner.new("le")
      BEncodr::Parser.parse_list(scanner).should == []
    end

    it "should parse a bencoded list containing a string" do
      scanner = StringScanner.new("l6:stringeeeee")
      BEncodr::Parser.parse_list(scanner).should == ["string"]
    end

    it "should parse a bencoded list containing more than one string" do
      scanner = StringScanner.new("l6:string6:stringe")
      BEncodr::Parser.parse_list(scanner).should == ["string", "string"]
    end

    it "should parse a bencoded list containing an integer" do
      scanner = StringScanner.new("li1ee")
      BEncodr::Parser.parse_list(scanner).should == [1]
    end

    it "should parse a bencoded list containing more than one integer" do
      scanner = StringScanner.new("li1ei2ee")
      BEncodr::Parser.parse_list(scanner).should == [1, 2]
    end

    it "should parse a bencoded list containing a list" do
      scanner = StringScanner.new("llee")
      BEncodr::Parser.parse_list(scanner).should == [[]]
    end

    it "should parse a bencoded list containing more than one list" do
      scanner = StringScanner.new("llelee")
      BEncodr::Parser.parse_list(scanner).should == [[], []]
    end

    it "should parse a bencoded list containing a dictionary" do
      scanner = StringScanner.new("ldee")
      BEncodr::Parser.parse_list(scanner).should == [{}]
    end

    it "should parse a bencoded list containing more than one dictionary" do
      scanner = StringScanner.new("ldedee")
      BEncodr::Parser.parse_list(scanner).should == [{}, {}]
    end

    it "should raise an error if there is no starting l" do
      scanner = StringScanner.new("e")
      lambda{BEncodr::Parser.parse_list(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      scanner = StringScanner.new("l")
      lambda{BEncodr::Parser.parse_list(scanner)}.should raise_error BEncodr::BEncodeError
    end
  end

  describe "#parse_dictionary" do
    it "should parse an empty bencoded dictionary" do
      scanner = StringScanner.new("de")
      BEncodr::Parser.parse_dictionary(scanner).should == {}
    end

    it "should parse a bencoded dictionary containing a key value pair" do
      scanner = StringScanner.new("d6:stringi1ee")
      BEncodr::Parser.parse_dictionary(scanner).should == {"string" => 1}
    end

    it "should parse a bencoded dictionary containing more than one key value pair" do
      scanner = StringScanner.new("d7:anotherle6:stringi1ee")
      BEncodr::Parser.parse_dictionary(scanner).should == {"string" => 1, "another" => []}
    end

    it "should raise an error if there is no starting d" do
      scanner = StringScanner.new("e")
      lambda{BEncodr::Parser.parse_dictionary(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if the key is not a string" do
      scanner = StringScanner.new("di1ei1ee")
      lambda{BEncodr::Parser.parse_dictionary(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if there is no closing e" do
      scanner = StringScanner.new("d")
      lambda{BEncodr::Parser.parse_dictionary(scanner)}.should raise_error BEncodr::BEncodeError
    end

    it "should raise an error if there is a key with no value" do
      scanner = StringScanner.new("d1:ae")
      lambda{BEncodr::Parser.parse_dictionary(scanner)}.should raise_error BEncodr::BEncodeError
    end
  end
end