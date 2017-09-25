class ChmkDiscounter < Discounter
  def name
    'CHMK'
  end

  def discountable_items(checkout)
    items = checkout.basket
    has_chai = !items.count(&:chai?).zero?
    milk = items.find(&:milk?)
    has_chai && milk ? [milk] : []
  end
end