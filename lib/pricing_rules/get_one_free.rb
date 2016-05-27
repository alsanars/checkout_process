require_relative '../pricing_rules'

class GetOneFree < PricingRules
  def initialize(code: 'VOUCHER')
    @code = code
  end

  def eligible?(item)
    return false unless applicable?(item)
    item.quantity > 1
  end

  def compute(item)
    return 0 unless eligible?(item)
    item.product.price * (item.quantity / 2)
  end
end
