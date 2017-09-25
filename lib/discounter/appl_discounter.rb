class ApplDiscounter < Discounter
  def name
    'APPL'
  end

  def amount
    1.50
  end

  def discountable_items(checkout)
    items = checkout.basket
    apples_list = items.select(&:apples?)
    apples_list.size >= 3 ? apples_list : []
  end
end