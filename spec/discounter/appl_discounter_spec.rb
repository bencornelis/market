require 'spec_helper'

describe ApplDiscounter do
  describe '#discountable_items' do
    let(:discounter) { ApplDiscounter.new }

    context 'when the basket has at least 3 apples' do
      it 'returns all the apples' do
        checkout = create_checkout('AP1 AP1 MK1 AP1')
        items = discounter.discountable_items(checkout)

        expect(items.size).to eq 3
        expect(items.map(&:apples?)).to all(be true)
      end
    end

    context 'when the basket has fewer than 3 apples' do
      it 'is empty' do
        checkout = create_checkout('AP1 MK1 AP1')
        items = discounter.discountable_items(checkout)

        expect(items).to be_empty
      end
    end
  end
end