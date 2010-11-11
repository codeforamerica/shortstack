require 'test_helper'

class ContributionTest < ActiveSupport::TestCase
  context "Contribution " do
    setup do
      Factory(:contribution)
    end
  
    should belong_to :contributable
    should belong_to :user
  end

end
