require 'pry'
require 'rspec'
require 'support/checkout_helpers'
require 'checkout'
require 'item'
require 'printer'
require 'discount'
require 'discounter'
require 'discounter/appl_discounter'
require 'discounter/bogo_discounter'
require 'discounter/chmk_discounter'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
end