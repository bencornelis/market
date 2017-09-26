require 'yaml'

class Item
  def self.from_code(code)
    market = YAML.load_file(File.join(__dir__, 'market.yml'))
    unless market[code]
      raise ArgumentError.new 'No item with that code exists.'
    end

    name  = market[code]['name']
    price = market[code]['price']
    new(code, name, price)
  end

  attr_reader :code, :name, :price
  attr_accessor :discount

  def initialize(code, name, price)
    @code     = code
    @name     = name
    @price    = price
    @discount = nil
  end

  def discounted_price
    price - discount_amount
  end

  def discount_amount
    return 0 unless discount
    discount.free? ? price : discount.amount
  end

  def discounted?
    !discount.nil?
  end

  def chai?
    code == 'CH1'
  end

  def coffee?
    code == 'CF1'
  end

  def apples?
    code == 'AP1'
  end

  def milk?
    code == 'MK1'
  end
end