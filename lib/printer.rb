class Printer
  def initialize(checkout)
    @checkout = checkout
  end

  def print_register
    table = collect_rows
    [*headers, *table].each do |row|
      left   = row[0].ljust(10, ' ')
      center = row[1].ljust(13, ' ')
      right  = row[2].rjust(6, ' ')
      puts "#{left}#{center}#{right}"
    end
    puts '-'*29
    puts "#{format_price(checkout.total_price)}".rjust(29, ' ')
  end

  private

  attr_reader :checkout

  def collect_rows
    checkout.basket.each_with_object([]) do |item, rows|
      rows << [item.code, '', format_price(item.price)]
      next unless item.discounted?
      discount = item.discount
      rows << ['', discount.name, "-#{format_price(item.discount_amount)}"]
    end
  end

  def format_price(price)
    '%.2f' % price
  end

  def headers
    [
      ['Item', 'Discount', 'Price'],
      ['----', '--------', '-----']
    ]
  end
end