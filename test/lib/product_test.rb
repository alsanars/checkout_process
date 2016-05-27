require_relative '../test_helper'

describe Product do
  let(:voucher) { { code: 'VOUCHER', name: 'Voucher', price: 5.00 } }
  let(:product) { Product.new(voucher).save }

  it { product.must_be_instance_of Product }
  it { product.code.must_equal 'VOUCHER' }
  it { product.name.must_equal 'Voucher' }
  it { product.price.must_be_kind_of Float }
  it { product.price.must_equal 5.00 }

  describe '#save' do
    describe 'price update' do
      let(:product_updated) { product.price = -1 }

      it 'cant be lte zero' do
        proc { product_updated.save }.must_raise Exception
      end
    end
  end

  it '.products' do
    Product.products.must_be_instance_of Hash
  end

  it '.find_by' do
    Product.find_by(code: product.code).must_be_instance_of Product
  end
end
