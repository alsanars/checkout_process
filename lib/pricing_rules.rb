class PricingRules
  attr_reader :code

  def initialize(code:)
    @code = code
  end

  def applicable?(item)
    return false unless item.kind_of? Item
    item.product.code == @code
  end

  def eligible?(item)
    applicable?(item)
  end

  def compute(item)
    0 # Default compute
  end

  private
    # INFO: .builder to initialize all PricingRules subclasses.
    # Returns an array of subclasses.
    def self.builder
      default_rules = ObjectSpace.each_object(Class).select { |rule| rule < self }
      default_rules.map { |rule| rule.new }
    end
end
