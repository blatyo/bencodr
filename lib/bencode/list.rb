module BEncode
  module List
    module Generic
      module InstanceMethods
        # Encodes object into a bencoded list. BEncoded strings are length-prefixed base ten followed by a colon and
        # the string. Object must implement to_a or to_ary.
        #
        # [].bencode #=> "le"
        def bencode
          (respond_to?(:to_a) ? to_a : to_ary).bencode
        end
      end
    end

    # Registers a class as an object that can be converted into a bencoded list. Class must have instance method to_a
    # or to_ary.
    #
    # class MyClass
    #   def to_a
    #     [1, :cat]
    #   end
    # end
    #
    # BEncode::Integer.register MyClass
    # my_class = MyClass.new
    # my_class.bencode  #=> "li1e3:cate"
    def self.register(type)
      type.class_eval {include Generic::InstanceMethods}
    end

    module Array
      module InstanceMethods
        # Encodes an array into a bencoded list. Bencoded lists are encoded as an 'l' followed by their elements (also
        # bencoded) followed by an 'e'.
        #
        # [:eggs, "ham", 3, 4.1].bencode #=> "l4:eggs3:hami3ei4ee"
        def bencode
          collect do |element|
            element.bencode
          end.unshift(:l).push(:e).join
        end
      end

      ::Array.class_eval {include InstanceMethods}
    end
  end
end