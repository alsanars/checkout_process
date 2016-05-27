class Checkout
  attr_reader :pricing_rules, :items

  def initialize(pricing_rules = [])
    @items = {}
    @pricing_rules = pricing_rules
  end

  def scan(code)
    product = Product.find_by(code: code)
    raise 'Product not found!' if product.nil?
    item = @items[product.code]
    item ? item.quantity += 1 : @items[product.code] = Item.new(product: product)
  end

  def total
    @items.values.inject(0) { |sum, item| sum + (item.amount - discount(item: item)) }
  end

  def discount(item:)
    @pricing_rules.inject(0) { |sum, rule| sum + rule.compute(item) }
  end
end
