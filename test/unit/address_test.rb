require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  context "Address " do
    setup do
      Factory(:address)
    end
  
  should belong_to :addressable
  
  end
end
