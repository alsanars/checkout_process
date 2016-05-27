require_relative '../../test_helper'

describe GetOneFree do
  let(:voucher) { Product.new({ code: 'VOUCHER', name: 'Voucher', price: 5.00 }) }
  let(:tshirt)  { Product.new({ code: 'TSHIRT', name: 'T-Shirt', price: 20.00 }) }
  let(:mug)     { Product.new({ code: 'MUG', name: 'Coffee Mug', price: 7.50 }) }

  let(:pricing_rule) { GetOneFree.new(code: 'VOUCHER') }

  let(:voucher_item) { Item.new(product: voucher, quantity: 2) }
  let(:tshirt_item)  { Item.new(product: tshirt, quantity: 2) }
  let(:mug_item)     { Item.new(product: mug, quantity: 2) }

  describe '#eligible?' do
    it 'mustnt with incorrect product code' do
      pricing_rule.eligible?(tshirt_item).wont_equal true
      pricing_rule.eligible?(mug_item).wont_equal true
    end

    it 'must with correct product code' do
      pricing_rule.eligible?(voucher_item).must_equal true
    end
  end

  describe '#compute' do
    it 'discounts price of one for each two' do
      pricing_rule.compute(voucher_item).must_equal 5.00
    end
  end
end
