# encoding: UTF-8

require "spec"
require "spec_helper"

describe BEncodr::Ext do
  describe "#include!" do
    before :all do
      BEncodr::Ext.include!
    end
    
    context BEncodr::String do
      context ::String do
        it "should respond to bencode" do
          "".should respond_to(:bencode)
        end
      
        it "should be a BEncodr::String" do
          "".is_a?(BEncodr::String).should be_true
        end
        
        it "should respond to bdecode" do
          "".should respond_to(:bdecode)
        end
        
        it "should be a BEncodr::Object" do
          "".is_a?(BEncodr::Object).should be_true
        end
      end
    
      context Symbol do
        it "should respond to bencode" do
          :a.should respond_to(:bencode)
        end
      
        it "should be a BEncodr::String" do
          :a.is_a?(BEncodr::String).should be_true
        end
      end
    
      context URI::Generic do
        before :each do
          @uri = URI.parse("www.google.com") 
        end
      
        it "should respond to bencode" do
          @uri.should respond_to(:bencode)
        end
      
        it "should be a BEncodr::String" do
          @uri.is_a?(BEncodr::String).should be_true
        end
      end
    end
    
    context BEncodr::Integer do
      context Numeric do
        it "should respond to bencode" do
          1.should respond_to(:bencode)
        end
      
        it "should be a BEncodr::Integer" do
          1.is_a?(BEncodr::Integer).should be_true
        end
      end
      
      context Time do
        it "should respond to bencode" do
          Time.at(0).should respond_to(:bencode)
        end
      
        it "should be a BEncodr::Integer" do
          Time.at(0).is_a?(BEncodr::Integer).should be_true
        end
      end
    end
    
    context BEncodr::List do
      context Array do
        it "should respond to bencode" do
          [].should respond_to(:bencode)
        end
      
        it "should be a BEncodr::List" do
          [].is_a?(BEncodr::List).should be_true
        end
      end
    end
    
    context BEncodr::Dictionary do
      context Hash do
        it "should respond to bencode" do
          {}.should respond_to(:bencode)
        end
      
        it "should be a BEncodr::Dictionary" do
          {}.is_a?(BEncodr::Dictionary).should be_true
        end
      end
    end
    
    context BEncodr::IO do
      context IO do
        it "should respond to bencode" do
          IO.should respond_to(:bencode)
        end
      
        context "with an instance" do
          before :each do
            @rd, @wr = IO.pipe
          end
          
          it "should be a BEncodr::IO" do  
            @rd.is_a?(BEncodr::IO).should be_true
          end
          
          it "should respond to bencode" do
            @rd.should respond_to(:bencode)
          end
          
          after :each do
            @rd.close
            @wr.close
          end
        end
      end
      
      context File do
        it "should respond to bencode" do
          File.should respond_to(:bencode)
        end
        
        context "with an instance" do
          before :each do
            @file = File.open(__FILE__)
          end
          
          it "should be a BEncodr::IO" do
            @file.is_a?(BEncodr::IO).should be_true
          end
          
          it "should respond to bencode" do
            @file.should respond_to(:bencode)
          end
          
          after :each do
            @file.close
          end
        end
      end
    end
  end
end