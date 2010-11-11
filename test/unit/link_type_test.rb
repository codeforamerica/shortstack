require 'test_helper'

class LinkTypeTest < ActiveSupport::TestCase
  context "LinkType " do
    setup do
      Factory(:link_type)
    end
  
    should have_many :links
  end
end
