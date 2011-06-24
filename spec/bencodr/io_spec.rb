# encoding: UTF-8
require "spec_helper"

describe File do
  before :all do
    @path = "tmp"
    Dir.mkdir(@path) unless File.exists? @path
    BEncodr.include!
  end

  before :each do
    @file = File.join(@path, 'test.bencodr')
    @object = "string"
    File.bencode(@file, @object)
  end
  
  describe "#bencode" do
    subject{ File }
    
    it{ File.should exist(@file) }
  end
  
  describe "#bdecode" do
    subject{ File }
    it{ should bdecode(@file).to(@object) }
  end
  
  after :each do
    File.delete(@file)
  end

  after :all do
    Dir.delete(@path) if File.exists? @path
  end
end