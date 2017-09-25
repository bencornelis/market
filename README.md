## market

### Usage

Creating items from item codes:
```ruby
  chai = Item.from_code('CH1')
  chai.price
  # => 3.11
  
  apples = Item.from_code('AP1')
  apples.price
  # => 6.0
  
  milk = Item.from_code('MK1')
  milk.price
  # => 4.75
```

To initialize a checkout basket with discounts, use `with_discounts` instead of `new`:

```ruby
  checkout = Checkout.with_discounts
  [chai, apples, milk].each { |item| checkout.scan(item) }
  
  checkout.show
  # =>
  Item      Discount      Price
  ----      --------      -----
  CH1                      3.11
  AP1                      6.00
  MK1                      4.75
            CHMK          -4.75
  -----------------------------
                           9.11
```

### Testing

Testing is done with RSpec. To run all specs use the `rspec` command.

### Extending Functionality

To create a new type of discount, all we need to do is add a new class to the `discounter` folder that satisfies the following requirements:

* implements `name`
* implements `discountable_items`, which takes the `checkout` as its argument

For example, suppose we later decide we want to make all boxes of chai after the first $1 off. We decide to name the discount `CHDO`. We add the following:

```ruby
# discounter/chdo_discounter.rb
class ChdoDiscounter < Discounter
  def name
    'CHDO'
  end

  def amount
    1.00
  end

  def discountable_items(checkout)
    items = checkout.basket
    items.map(&:chai?).drop(1)
  end
end
```

Adding a new item requires updating the `market.yml` file: 

```ruby
# market.yml
...
YG1:
  name: Yogurt
  price: 2.50
```

Adding the following helper method is also helpful for implementing yogurt discounts:

```ruby
# item.rb
class Item
  ...
  def yogurt?
    code == 'YG1'
  end
end
```


