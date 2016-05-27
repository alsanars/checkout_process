require_relative '../pricing_rules'

class BulkPurchase < PricingRules
  attr_accessor :quantity, :discount

  def initialize(code: 'TSHIRT', quantity: 3, discount: 1)
    super(code: code)
    @quantity = quantity
    @discount = discount
  end

  def eligible?(item)
    return false unless applicable?(item)
    item.quantity >= @quantity
  end

  def compute(item)
    return 0 unless eligible?(item)
    @discount * item.quantity
  end
end
