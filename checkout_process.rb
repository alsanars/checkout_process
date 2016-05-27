load_paths = Dir['./lib/*.rb', './lib/*/*.rb']
load_paths.each { |file| require file }

def totals(checkout)
  puts "Items: #{checkout.items.values.map { |item| "#{item.product.code}(#{item.quantity} units)" }.join(', ')}"
  puts "Total: #{checkout.total}\n\n"
end

product_attrs = [
  { code: 'VOUCHER', name: 'Voucher', price: 5.00 },
  { code: 'TSHIRT', name: 'T-Shirt', price: 20.00 },
  { code: 'MUG', name: 'Coffee Mug', price: 7.50 }
]
product_attrs.each { |attrs| Product.new(attrs).save }
pricing_rules = PricingRules.builder

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("TSHIRT")
co.scan("MUG")
totals(co)

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("VOUCHER")
co.scan("TSHIRT")
totals(co)

co = Checkout.new(pricing_rules)
co.scan("TSHIRT")
co.scan("TSHIRT")
co.scan("TSHIRT")
co.scan("VOUCHER")
co.scan("TSHIRT")
totals(co)

co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("TSHIRT")
co.scan("VOUCHER")
co.scan("VOUCHER")
co.scan("MUG")
co.scan("TSHIRT")
co.scan("TSHIRT")
totals(co)
