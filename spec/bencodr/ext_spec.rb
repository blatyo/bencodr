# encoding: UTF-8
require "spec_helper"

describe BEncodr::Ext do
  describe "#include!" do
    before :all do
      BEncodr::Ext.include!
    end
    
    context BEncodr::String do
      context ::String do
        it_behaves_like "a BEncodr extension", "", BEncodr::String
        
        subject{ "" }
        it { should be_a(BEncodr::Object) }
        it { should respond_to(:bdecode) }
      end
    
      context Symbol do
        it_behaves_like "a BEncodr extension", :a, BEncodr::String
      end
    
      context URI::Generic do
        it_behaves_like "a BEncodr extension", URI.parse("www.google.com"), BEncodr::String
      end
    end
    
    context BEncodr::Integer do
      context Numeric do
        it_behaves_like "a BEncodr extension", 1, BEncodr::Integer
      end
      
      context Time do
        it_behaves_like "a BEncodr extension", Time.at(0), BEncodr::Integer
      end
    end
    
    context BEncodr::List do
      context Array do
        it_behaves_like "a BEncodr extension", [], BEncodr::List
      end
    end
    
    context BEncodr::Dictionary do
      context Hash do
        it_behaves_like "a BEncodr extension", {}, BEncodr::Dictionary
      end
    end
    
    context BEncodr::IO do
      context IO do
        subject{IO}
        it{ should respond_to(:bencode) }
                
        it_behaves_like "a BEncodr extension", IO.new(0), BEncodr::IO
      end
      
      context File do
        subject{File}
        it{ should respond_to(:bencode) }
        
        it_behaves_like "a BEncodr extension", File.open(File.dirname(__FILE__)), BEncodr::IO
      end
    end
  end
end