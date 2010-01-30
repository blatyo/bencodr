# encoding: UTF-8

module BEncode
  module Dictionary
    module Generic
      module InstanceMethods
        # Encodes an array into a bencoded dictionary. Bencoded dictionaries are encoded as a 'd' followed by a list of
        # alternating keys and their corresponding values followed by an 'e'. Keys appear in sorted order (sorted as raw
        # strings, not alphanumerics).
        #
        #   {:cow => "moo", :seven => 7}.bencode #=> "d3:cow3:moo5:seveni7ee"
        #
        # @return [String] the bencoded dictionary
        def bencode
          (respond_to?(:to_h) ? to_h : to_hash).bencode
        end
      end
    end

    # Registers a class as an object that can be converted into a bencoded dictionary. Class must have instance method
    # to_h or to_hash.
    #
    #   class MyClass
    #     def to_h
    #       {:a => :a, :b => 1}
    #     end
    #   end
    #
    #   BEncode::String.register MyClass
    #   my_class = MyClass.new
    #   my_class.bencode  #=> "d1:a1:a1:bi1ee"
    #
    # @param [Class#to_h, Class#to_hash] type the class to add the bencode instance method to
    def self.register(type)
      type.send :include, Generic::InstanceMethods
    end

    module Hash
      module InstanceMethods
        # Encodes an array into a bencoded dictionary. Bencoded dictionaries are encoded as a 'd' followed by a list of
        # alternating keys and their corresponding values followed by an 'e'. Keys appear in sorted order (sorted as raw
        # strings, not alphanumerics).
        #
        #   {:cow => "moo", :seven => 7}.bencode #=> "d3:cow3:moo5:seveni7ee"
        #
        # @return [String] the bencoded dictionary 
        def bencode
          keys.sort{|a, b| a.to_s <=> b.to_s}.collect do |key|
            key.to_s.bencode + self[key].bencode
          end.unshift(:d).push(:e).join
        end
      end

      ::Hash.send :include, InstanceMethods
    end
  end
end