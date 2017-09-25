class Discount
  attr_reader :name, :amount

  def initialize(name, amount = nil)
    @name   = name
    @amount = amount
  end

  def free?
    amount.nil?
  end
end