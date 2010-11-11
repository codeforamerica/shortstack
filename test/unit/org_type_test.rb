require 'test_helper'

class OrgTypeTest < ActiveSupport::TestCase

  context "Org Type " do
    setup do
      Factory(:org_type)
    end
  
    should have_many :organizations
  end

end
