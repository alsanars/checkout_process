require_relative '../test_helper'

describe PricingRules do
  let(:sticker) { Product.new({ code: 'STICKER', name: 'Sticker', price: 2.90 }) }
  let(:sticker_item) { Item.new(product: sticker) }
  let(:notebook) { Product.new({ code: 'NOTEBOOK', name: 'Notebook', price: 8.90 }) }
  let(:notebook_item) { Item.new(product: notebook) }
  let(:pricing_rule) { PricingRules.new(code: 'STICKER') }

  describe '#applicable?' do
    it 'must be an Item' do
      pricing_rule.applicable?(sticker_item).must_equal true
    end
  end

  describe '#eligible?' do
    it 'shouldnt with incorrect product code' do
      pricing_rule.eligible?(notebook_item).wont_equal true
    end

    it 'should with correct product code' do
      pricing_rule.eligible?(sticker_item).must_equal true
    end
  end

  describe '#compute' do
    it 'should return zero when called from parent class' do
      pricing_rule.compute(sticker_item).must_equal 0
    end
  end

  describe '.builder' do
    let(:pricing_rules) { PricingRules.builder }

    it 'should return rules array' do
      pricing_rules.must_be_kind_of Array
    end
  end
end
