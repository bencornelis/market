require 'spec_helper'

describe Checkout do
  describe '#total_price' do
    it 'calculates the total price with discounts applied' do
      checkout1 = create_checkout('CH1 AP1 CF1 MK1')
      checkout2 = create_checkout('MK1 AP1')
      checkout3 = create_checkout('CF1 CF1')
      checkout4 = create_checkout('AP1 AP1 CH1 AP1')

      [checkout1, checkout2, checkout3, checkout4].each(&:apply_discounts)

      expect(checkout1.total_price).to eq 20.34
      expect(checkout2.total_price).to eq 10.75
      expect(checkout3.total_price).to eq 11.23
      expect(checkout4.total_price).to eq 16.61
    end
  end

  describe '#show' do
    context 'when no discounts are applied' do
      it 'only displays the items' do
        checkout = create_checkout('MK1 AP1')

        register = <<~EOS
        Item      Discount      Price
        ----      --------      -----
        MK1                      4.75
        AP1                      6.00
        -----------------------------
                                10.75
        EOS

        expect { checkout.show }.to output(register).to_stdout
      end
    end

    context 'when at least two coffees are in the basket' do
      it 'also shows the BOGO discount' do
        checkout = create_checkout('CF1 CF1')

        register = <<~EOS
        Item      Discount      Price
        ----      --------      -----
        CF1                     11.23
        CF1                     11.23
                  BOGO         -11.23
        -----------------------------
                                11.23
        EOS

        expect { checkout.show }.to output(register).to_stdout
      end
    end

    context 'when at least three apples are in the basket' do
      it 'also shows the APPL discount' do
        checkout = create_checkout('AP1 AP1 CH1 AP1')

        register = <<~EOS
        Item      Discount      Price
        ----      --------      -----
        AP1                      6.00
                  APPL          -1.50
        AP1                      6.00
                  APPL          -1.50
        CH1                      3.11
        AP1                      6.00
                  APPL          -1.50
        -----------------------------
                                16.61
        EOS

        expect { checkout.show }.to output(register).to_stdout
      end
    end

    context 'when a chai and milk are in the basket' do
      it 'also shows the CHMK discount' do
        checkout = create_checkout('CH1 AP1 CF1 MK1')

        register = <<~EOS
        Item      Discount      Price
        ----      --------      -----
        CH1                      3.11
        AP1                      6.00
        CF1                     11.23
        MK1                      4.75
                  CHMK          -4.75
        -----------------------------
                                20.34
        EOS

        expect { checkout.show }.to output(register).to_stdout
      end
    end

    context 'when there are multiple discounts' do
      it 'shows all the discounts' do
        checkout = create_checkout('CH1 AP1 AP1 AP1 MK1')

        register = <<~EOS
        Item      Discount      Price
        ----      --------      -----
        CH1                      3.11
        AP1                      6.00
                  APPL          -1.50
        AP1                      6.00
                  APPL          -1.50
        AP1                      6.00
                  APPL          -1.50
        MK1                      4.75
                  CHMK          -4.75
        -----------------------------
                                16.61
        EOS

        expect { checkout.show }.to output(register).to_stdout
      end
    end
  end
end