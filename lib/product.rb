require_relative 'validations'

class Product
  include Validations
  attr_reader :code
  attr_accessor :name, :price

  def initialize(code:, name:, price:)
    @code  = code
    @name  = name
    @price = price
  end

  def save
    raise 'Products price must be greather than 0' unless gt_than_zero?(self.price)
    self.class.products[self.code] = self
  end

  def self.products
    @products ||= {}
  end

  def self.find_by(code:)
    products[code]
  end
end
