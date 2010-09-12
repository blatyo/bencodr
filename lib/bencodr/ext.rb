module BEncodr
  module Ext
    def self.include!
      include_string!
      include_integer!
      include_list!
      include_dictionary!
      include_io!
    end
    
    private
    
    def self.include_string!
      [::String, Symbol, URI::Generic].each do |stringable|
        stringable.send :include, String
      end
    end
    
    def self.include_integer!
      [Numeric, Time].each do |intable|
        intable.send :include, Integer
      end
    end
    
    def self.include_list!
      Array.send :include, List
    end
    
    def self.include_dictionary!
      Hash.send :include, Dictionary
    end
    
    def self.include_io!
      ::IO.send :include, IO
    end
  end
end