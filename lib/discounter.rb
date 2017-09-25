class Discounter
  def self.types
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def discount
    @discount ||= Discount.new(name, amount)
  end

  def name
    raise 'Implement #name in subclass'
  end

  def amount
    nil
  end

  def apply_discount(checkout)
    discountable_items(checkout).each do |item|
      item.discount = discount
    end
  end

  def discountable_items(checkout)
    raise 'Implement #discountable_items in subclass'
  end
end