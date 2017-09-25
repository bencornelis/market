require 'spec_helper'

describe ChmkDiscounter do
  describe '#discountable_items' do
    let(:discounter) { ChmkDiscounter.new }

    context 'when the basket has a box of chai' do
      it 'returns the first carton of milk' do
        checkout = create_checkout('CH1 AP1 MK1 MK1')
        items = discounter.discountable_items(checkout)

        expect(items.size).to eq 1
        expect(items.first.milk?).to be true
      end
    end

    context 'when the basket does not have a box of chai' do
      it 'is empty' do
        checkout = create_checkout('AP1 MK1')
        items = discounter.discountable_items(checkout)

        expect(items).to be_empty
      end
    end
  end
end