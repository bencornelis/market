class Printer
  def initialize(checkout)
    @checkout = checkout
  end

  def print_register
    [*headers, *collect_rows].each { |row| print_row(row) }
    print_divider
    print_total
  end

  private

  attr_reader :checkout

  def print_row(row)
    left   = row[0].ljust(10, ' ')
    center = row[1].ljust(13, ' ')
    right  = row[2].rjust(6, ' ')
    puts "#{left}#{center}#{right}"
  end

  def print_divider
    puts '-'*29
  end

  def print_total
    puts "#{format_price(checkout.total_price)}".rjust(29, ' ')
  end

  def collect_rows
    checkout.basket.each_with_object([]) do |item, rows|
      rows << [item.code, '', format_price(item.price)]
      next unless item.discounted?
      rows << ['', item.discount.name, "-#{format_price(item.discount_amount)}"]
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