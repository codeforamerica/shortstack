require 'test_helper'

class ContributionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Contribution.new.valid?
  end
end
