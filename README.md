# BEncodr
* **Author** Allen Madsen (blatyo)
* **My Site** http://www.allenmadsen.com
* **Gem** http://gemcutter.org/gems/bencodr
* **Source** http://github.com/blatyo/bencodr
* **Issue Tracker** http://github.com/blatyo/bencodr/issues

## Synopsis
This gem provides a way to encode and parse bencodings used by the Bit Torrent protocol.

_Note: If using ruby 1.8.x, use bencodr version 2.1.0. 3.0.0 is 1.9.x only, because it uses the 1.9.x encoding features._

## Installation

Install the gem:

``` bash
    gem install bencodr
```

Require it in your ruby files:

``` ruby
    require 'bencodr'
```

## Usage
### BEncodr
Most of the functionality of this library can be accessed directly on the BEncodr class.

``` ruby
    # encoding is just like calling bencode on the object
    BEncodr.bencode("string")    #=> "6:string"

    # decoding is just like calling bdecode on a bencoding
    BEncodr.bdecode("6:string")  #=> "string"

    # you can work directly with files too
    BEncodr.bencode_file("my_awesome.torrent", {:announce => "http://www.sometracker.com/announce:80"})
    BEncodr.bdecode_file("my_awesome.torrent") #=> {:announce => "http://www.sometracker.com/announce:80"}
```

### Monkey Patching
In order to get this functionality on the objects described below, you can call:

``` ruby
    BEncodr.include!
```

This will extend:

* BEncodr::String
    * String
    * Symbol
    * URI::Generic
    * URI::FTP
    * URI::HTTP
    * URI::HTTPS
    * URI::LDAP
    * URI::LDAPS
* BEncodr::Integer
    * Numeric
    * Time
    * Date
    * DateTime
* BEncodr::List
    * Array
* BEncodr::Dictionary
    * Hash
* BEncodr::IO
    * IO
    * File

### String
BEncoded strings are length-prefixed base ten followed by a colon and the string.

``` ruby
    # strings
    "".bencode              #=> "0:"
    "string".bencode        #=> "6:string"

    # symbols
    :symbol.bencode         #=> "6:symbol"

    # URIs
    uri = URI.parse("http://github.com/blatyo/bencode")
    uri.bencode             #=> "32:http://github.com/blatyo/bencode"
```

### Integer
Bencoded integers are represented by an 'i' followed by the number in base 10 followed by an 'e'.

``` ruby
    # integers
    1.bencode               #=> "i1e"
    -1.bencode              #=> "i-1e"
    10_000_000_000.bencode  #=> "i10000000000e"

    # other numerics
    1.1.bencode             #=> "i1e"
    -1e10.bencode           #=> "i-10000000000e"

    # times
    Time.at(4).bencode      #=> "i4e"
```

### List
Bencoded lists are encoded as an 'l' followed by their elements (also bencoded) followed by an 'e'.

``` ruby
    # arrays
    [].bencode                        #=> "le"
    [:e, "a", 1, Time.at(11)].bencode #=> "l1:e1:ai1ei11ee"
```

### Dictionary
Bencoded dictionaries are encoded as a 'd' followed by a list of alternating keys and their corresponding values
followed by an 'e'. Keys appear in sorted order (sorted as raw strings, not alphanumerics) and are always strings.

``` ruby
    # hashes
    {}.bencode                          #=> "de"
    {"string" => "string"}.bencode      #=> "d6:string6:stringe"
    {:symbol => :symbol}.bencode        #=> "d6:symbol6:symbole"
    {1 => 1}.bencode                    #=> "d1:1i1ee"
    {1.1 => 1.1}.bencode                #=> "d3:1.1i1ee"
    {{} => {}}.bencode                  #=> "d2:{}dee"

    time = Time.utc(0)
    {time => time}.bencode              #=> "d23:2000-01-01 00:00:00 UTCi946684800ee"

    array = (1..4).to_a
    {array => array}.bencode            #=> "d12:[1, 2, 3, 4]li1ei2ei3ei4eee"

    # Note: keys are sorted as raw strings.
    {:a => 1, "A" => 1, 1=> 1}.bencode  #=> "d1:1i1e1:Ai1e1:ai1ee"
```

### Decoding
You can decode a bencoding by calling bdecode on the string.

``` ruby
    "6:string".bdecode  #=> "string"
    "i1e".bdecode       #=> 1
    "le".bdecode        #=> []
    "de".bdecode        #=> {}
```

### IO and Files
You can also write and read bencodings.

``` ruby
    # write to standard out
    IO.bencode(1, "string")             #=> "6:string" to stdout
    $stdout.bencode("string")           #=> "6:string" to stdout

    # write to file
    File.bencode("a.bencode", "string") #=> "6:string" to a.bencode

    file = File.open("a.bencode", "wb")
    file.bencode("string")              #=> "6:string" to a.bencode

    # read from standard in
    IO.bdecode(0)                       #=> "string"
    $stdin.bdecode                      #=> "string"

    # read from file
    File.bdecode("a.bencode")           #=> "string"

    file = File.open("a.bencode", "wb")
    file.bdecode                        #=> "string"
```

### Make Your Own Objects Compatible
When using bencodings it may be useful to translate your own objects into bencoded strings.

``` ruby
    # register string type
    Range.send :include, BEncodr::String
    (1..2).bencode      #=> "4:1..2"

    # register integer type
    NilClass.send :include, BEncodr::Integer
    nil.bencode         #=> "i0e"

    # register list type
    Range.send :include, BEncodr::List
    (1..2).bencode      #=> "li1ei2ee"

    #register dictionary type
    MyClass = Class.new do
      include BEncodr::Dictionary

      def to_h
        {:a => "a", :b => "b"}
      end
    end

    MyClass.new.bencode #=> "d1:a1:a1:b1:be"
```

## Note on Reporting Issues

* Try to make a failing test case
* Tell me which version of ruby you're using
* Tell me which OS you are using
* Provide me with any extra files if necessary

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Allen Madsen. See LICENSE for details.
