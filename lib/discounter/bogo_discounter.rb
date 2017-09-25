class BogoDiscounter < Discounter
  def name
    'BOGO'
  end

  def discountable_items(checkout)
    items = checkout.basket
    coffees = checkout.basket.select(&:coffee?)
    free_coffees = coffees.drop(1).each_slice(2).map(&:first)
    free_coffees
  end
end