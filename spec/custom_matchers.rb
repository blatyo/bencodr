RSpec::Matchers.define :bencode_to do |expected|
  match do |actual|
    actual.bencode.should equal(expected)
  end
  
  failure_message_for_should do |actual|
    "expected that #{actual} would bencode to #{expected}"
  end
end

RSpec::Matchers.define :bencode do |actual|
  chain :to do |_expected|
    @_expected = _expected
  end
  
  match do |klass|
    klass.bencode(actual).should == @_expected
  end
  
  failure_message_for_should do |klass|
    "expected #{klass.name} to bencode #{actual} to #{@_expected}"
  end
end