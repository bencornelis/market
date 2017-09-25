require 'spec_helper'

describe BogoDiscounter do
  describe '#discountable_items' do
    let(:discounter) { BogoDiscounter.new }

    it 'returns every other coffee' do
      checkout = create_checkout('CF1 AP1 CF1 CF1 MK1 CF1')
      items = discounter.discountable_items(checkout)

      expect(items.size).to eq 2
      expect(items.map(&:coffee?)).to all(be true)
    end
  end
end