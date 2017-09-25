class Checkout
  def self.with_discounts
    discounters = Discounter.types.map(&:new)
    new(discounters)
  end

  attr_reader :basket

  def initialize(discounters = [])
    @basket = []
    @discounters = discounters
    @printer = Printer.new(self)
  end

  def scan(item)
    @basket << item
  end

  def total_price
    apply_discounts
    calculate_price
  end

  def show
    apply_discounts
    print_register
  end

  private

  attr_reader :discounters, :printer

  def apply_discounts
    discounters.each do |discounter|
      discounter.apply_discount(self)
    end
  end

  def calculate_price
    basket.map(&:discounted_price).reduce(:+)
  end

  def print_register
    printer.print_register
  end
end