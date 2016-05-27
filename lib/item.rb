require_relative 'validations'

class Item
  include Validations
  attr_reader :product
  attr_accessor :quantity

  def initialize(product:, quantity: 1)
    @product  = product
    self.quantity = quantity
  end

  def quantity=(quantity)
    raise 'Item quantity must be greather than 0' unless gt_than_zero?(quantity)
    @quantity = quantity
  end

  def amount
    product.price * quantity
  end
end
