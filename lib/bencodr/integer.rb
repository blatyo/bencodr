# encoding: UTF-8

module BEncodr
  module Integer
    module Generic
      module InstanceMethods
        # Encodes object into a bencoded integer. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string. Object must implement to_i or to_int.
        #
        #   1.bencodr #=> "i1e"
        #
        # @return [::String] the bencoded integer
        def bencode
          (respond_to?(:to_i) ? to_i : to_int).bencode
        end
      end
    end

    # Registers a class as an object that can be converted into a bencoded integer. Class must have instance method to_i
    # or to_int.
    #
    #   class MyClass
    #     def to_i
    #       1
    #     end
    #   end
    #
    #   BEncodr::Integer.register MyClass
    #   my_class = MyClass.new
    #   my_class.bencodr  #=> "i1e"
    #
    # @param [Class#to_i, Class#to_int] type the class to add the bencodr instance method to
    def self.register(type)
      type.send :include, Generic::InstanceMethods
    end

    register Numeric
    register Time

    module Integer
      module InstanceMethods
        # Encodes an integer into a bencoded integer. Bencoded integers are represented by an 'i' followed by the number
        # in base 10 followed by an 'e'.
        #
        #   3.bencodr #=> "i3e"
        #   -3.bencodr #=> "i-3e"
        #
        # @return [::String] the bencoded integer
        def bencode
          [:i, self, :e].join
        end
      end

      ::Integer.send :include, InstanceMethods
    end
  end
end