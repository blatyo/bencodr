# encoding: UTF-8
require File.join(File.dirname(__FILE__), '..', 'lib', 'bencodr')
require 'rspec'
require 'fuubar'
require 'custom_matchers'
require 'shared_examples'

RSpec.configure do |c|
  c.formatter = Fuubar
  c.color_enabled = true
end
