require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase

  context "Organization " do
    setup do
      Factory(:organization)
    end
  
    should have_many :links
    should have_many :notes
    should have_many :contributions
    should have_many :addresses
    should have_many :relationships
    should have_many :products    
    should have_many :people
    should belong_to :org_type
    should validate_presence_of :name
    should validate_presence_of :org_type

  end

end
