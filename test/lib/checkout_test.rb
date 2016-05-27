require_relative '../test_helper'

describe Checkout do
  let(:voucher) { Product.new({ code: 'VOUCHER', name: 'Voucher', price: 5.00 }) }
  let(:tshirt) { Product.new({ code: 'TSHIRT', name: 'T-Shirt', price: 20.00 }) }
  let(:mug) { Product.new({ code: 'MUG', name: 'Coffee Mug', price: 7.50 }) }
  let(:co) { Checkout.new }

  before(:each) do
    [voucher, tshirt, mug].each { |product| product.save }
  end

  describe 'without pricing rules' do
    describe '#scan' do
      it 'must be an Item' do
        co.scan('VOUCHER')
        co.items['VOUCHER'].must_be_instance_of Item
      end

      it 'should increase item quantity' do
        co.scan('MUG')
        co.scan('MUG')
        co.items['MUG'].quantity.must_equal 2
      end
    end

    describe '#total' do
      it 'should return correct item total price' do
        co.scan('TSHIRT')
        co.scan('TSHIRT')
        co.scan('TSHIRT')
        co.scan('VOUCHER')
        co.scan('TSHIRT')
        co.total.must_equal 85.00
      end
    end
  end

  describe 'required pricing rules' do
    let(:pricing_rules) { PricingRules.builder }
    let(:co) { Checkout.new(pricing_rules) }

    it 'Items: VOUCHER, TSHIRT, MUG' do
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('MUG')
      co.total.must_equal 32.50
    end

    it 'Items: VOUCHER, VOUCHER, TSHIRT' do
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.total.must_equal 25.00
    end

    it 'Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT' do
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.total.must_equal 81.00
    end

    it 'Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT' do
      co.scan('VOUCHER')
      co.scan('TSHIRT')
      co.scan('VOUCHER')
      co.scan('VOUCHER')
      co.scan('MUG')
      co.scan('TSHIRT')
      co.scan('TSHIRT')
      co.total.must_equal 74.50
    end
  end
end
