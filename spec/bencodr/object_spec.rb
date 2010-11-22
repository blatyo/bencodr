# encoding: UTF-8
require "spec_helper"

describe BEncodr::Object do
  it_behaves_like "BEncodr::String", BEncodr::Object
  it_behaves_like "BEncodr::Integer", BEncodr::Object
  it_behaves_like "BEncodr::List", BEncodr::Object
  it_behaves_like "BEncodr::Dictionary", BEncodr::Object
end