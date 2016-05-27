module Validations
  def gt_than_zero?(value)
    raise 'Attribute is not a number' unless value.is_a?(Float) or value.is_a?(Integer)
    value > 0
  end
end
