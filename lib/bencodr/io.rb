class IO
  class << self
    # This method encodes the object and writes it to the specified output.
    #
    #   # write to standard out
    #   IO.bencode(1, "string")             #=> "6:string" to stdout
    #
    #   # write to file
    #   File.bencode("a.bencode", "string") #=> "6:string" to a.bencode
    #
    # @param [Object] fd the file descriptor to use for output
    # @param [Object] object the object to write
    def bencode(fd, object)
      open(fd, "wb") {|file| file.bencode object }
    end

    # This method reads from the specified input and decodes the object.
    #
    #   # read from standard in
    #   IO.bdecode(0)             #=> "string"
    #
    #   # read from file
    #   File.bdecode("a.bencode") #=> "string"
    #
    # @param [Object] fd the file descriptor to use for input
    # @param [Object] object the object to write
    def bdecode(fd)
      open(fd, "rb") {|file| file.bdecode}
    end
  end

  # This method encodes the object and writes.
  #
  #   # write to standard out
  #   $stdout.bencode("string") #=> "6:string" to stdout
  #
  #   # write to file
  #   file = File.open("a.bencode", "wb")
  #   file.bencode("string")    #=> "6:string" to a.bencode
  #
  # @param [Object] object the object to write
  def bencode(object)
    write object.bencode
  end

  # This method reads from the specified input and decodes the object.
  #
  #   # read from standard in
  #   $stdin.bdecode  #=> "string"
  #
  #   # read from file
  #   file = File.open("a.bencode", "wb")
  #   file.bdecode    #=> "string"
  #
  # @param [Object] fd the file descriptor to use for input
  # @param [Object] object the object to write
  def bdecode
    read.bdecode
  end
end