require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  should "be valid" do
    assert Product.new.valid?
  end
end
