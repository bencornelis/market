require 'spec_helper'

describe Item do
  describe '.from_code' do
    it 'creates an item by looking up properties for the code' do
      item = Item.from_code('AP1')

      expect(item.code).to eq 'AP1'
      expect(item.name).to eq 'Apples'
      expect(item.price).to eq 6.0
    end
  end

  describe '#discounted_price' do
    let(:item) { Item.new('MK1', 'Milk', 4.75) }

    context 'when the item has no discount' do
      it 'is the same as the regular price' do
        expect(item.discounted_price).to eq 4.75
      end
    end

    context 'when the item has a discount' do
      context 'when the discount is free' do
        it 'is zero' do
          item.discount = Discount.new('BOGO')

          expect(item.discounted_price).to be_zero
        end
      end

      context 'when the discount is an amount' do
        it 'takes that amount off the regular price' do
          item.discount = Discount.new('Mlk', 1.5)

          expect(item.discounted_price).to eql 3.25
        end
      end
    end
  end
end