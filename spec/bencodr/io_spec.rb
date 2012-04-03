# encoding: UTF-8
require "spec_helper"
require 'tempfile'

describe File do
  before :all do
    BEncodr.include!
  end

  let(:file)   { Tempfile.new('test.bencodr') }
  let(:object) { "string" }

  describe ".bencode" do
    it "should encode object to file" do
      File.bencode(file.path, object)
      file.rewind
      file.read.should == "6:string"
    end
  end

  describe "#bencode" do
    it "should encode object to file" do
      file.bencode(object)
      file.rewind
      file.read.should == "6:string"
    end
  end

  context "decode" do
    let(:sample_path) { 'spec/samples/bencodr.torrent' }

    before do
      file.bencode(object)
      file.rewind
    end

    describe ".bdecode" do
      it "should decode object from file" do
        File.bdecode(file.path).should == object
      end

      it "should decode sample file without error" do
        expect{ File.bdecode(sample_path) }.to_not raise_error
      end
    end

    describe "#bdecode" do
      it "should decode object from file" do
        file.bdecode.should == object
      end

      it "should decode sample file without error" do
        f = File.open(sample_path, 'rb')
        expect{ f.bdecode }.to_not raise_error
      end
    end
  end
end
