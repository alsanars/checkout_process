require_relative '../test_helper'

describe Item do
  let(:product) { Product.new({ code: 'VOUCHER', name: 'Voucher', price: 5.00 }) }
  let(:item)    { Item.new(product: product) }

  it { item.product.must_be_instance_of Product }
  it { item.quantity.must_be_kind_of Integer }
  it { item.quantity.must_equal 1 }
  it { item.amount.must_equal 5.00 }

  describe 'when quantity item updated' do
    let(:item) { Item.new(product: product, quantity: 2) }

    it 'amount should increase' do
      item.amount.must_equal 10.00
    end
  end

  describe 'when quantity decreases' do
    let(:item_attrs) {{product: product, quantity: 0 }}

    it 'quantity cant be lte zero' do
      proc { Item.new(item_attrs) }.must_raise Exception
    end
  end
end
