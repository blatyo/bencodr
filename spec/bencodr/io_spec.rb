require "spec"

describe File do
  describe "#bencode" do
    context "when an object gets bencoded and written to a file" do
      before :all do
        @path = "tmp"
        Dir.mkdir(@path) unless File.exists? @path
      end

      before :each do
        @file = File.join(@path, 'test.bencodr')
        @object = "string"
        File.bencode(@file, @object)
      end

      it "should actually write a file" do
        File.exists?(@file).should be_true
      end

      describe "#bdecode" do
        it "should properly encode the file" do
          File.bdecode(@file).should == @object
        end
      end

      after :each do
        File.delete(@file)
      end

      after :all do
        Dir.delete(@path) if File.exists? @path
      end
    end
  end
end