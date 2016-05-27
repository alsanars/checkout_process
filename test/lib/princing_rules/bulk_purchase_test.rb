require_relative '../../test_helper'

describe BulkPurchase do
  let(:voucher) { Product.new({ code: 'VOUCHER', name: 'Voucher', price: 5.00 }) }
  let(:tshirt)  { Product.new({ code: 'TSHIRT', name: 'T-Shirt', price: 20.00 }) }
  let(:mug)     { Product.new({ code: 'MUG', name: 'Coffee Mug', price: 7.50 }) }

  let(:pricing_rule) { BulkPurchase.new(code: 'TSHIRT', quantity: 3, discount: 1.00) }

  let(:tshirt_item)  { Item.new(product: tshirt, quantity: 3) }
  let(:voucher_item) { Item.new(product: voucher, quantity: 2) }
  let(:mug_item)     { Item.new(product: mug, quantity: 2) }

  describe '#eligible?' do
    let(:tshirt_item_low_quantity)  { Item.new(product: tshirt, quantity: 2) }

    it 'mustnt if product code !TSHIRT' do
      pricing_rule.eligible?(voucher_item).wont_equal true
      pricing_rule.eligible?(mug_item).wont_equal true
    end

    it 'mustnt if item quantity < rule quantity' do
      pricing_rule.eligible?(tshirt_item_low_quantity).wont_equal true
    end

    it 'must if product code TSHIRT & item quantity >= rule quantity' do
      pricing_rule.eligible?(tshirt_item).must_equal true
    end
  end

  describe '#compute' do
    it 'returns discount from items (discount x item.quantity)' do
      pricing_rule.compute(tshirt_item).must_equal 3.00
    end
  end
end
