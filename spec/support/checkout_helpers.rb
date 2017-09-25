def create_checkout(codes_str)
  checkout = Checkout.with_discounts
  codes = codes_str.split(' ')
  codes.each do |code|
    item = Item.from_code(code)
    checkout.scan(item)
  end
  checkout
end