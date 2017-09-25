require 'spec_helper'

describe Discount do
  describe '#free' do
    context 'when the discount has no amount' do
      it 'is true' do
        discount = Discount.new('BOGO')

        expect(discount.free?).to be true
      end
    end

    context 'when the discount has an amount' do
      it 'is false' do
        discount = Discount.new('APPL', 1.50)

        expect(discount.free?).to be false
      end
    end
  end
end