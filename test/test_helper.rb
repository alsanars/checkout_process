$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'minitest/reporters'
require 'pry'

require_relative '../lib/validations'
require_relative '../lib/product'
require_relative '../lib/item'
require_relative '../lib/checkout'
require_relative '../lib/pricing_rules'
require_relative '../lib/pricing_rules/get_one_free'
require_relative '../lib/pricing_rules/bulk_purchase'

Minitest::Reporters.use!(Minitest::Reporters::MeanTimeReporter.new({ color: true }))
