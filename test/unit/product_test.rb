require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  context "Product " do
    setup do
      Factory(:product)
    end
  
    should have_many :links
    should have_many :notes
    should have_many :contributions
    should have_many :addresses
    should have_many :relationships
    should have_many :products    
    should have_many :people
    
    should validate_presence_of :name

  end
  
end
