require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  context "Relationship" do
    setup do
      Factory(:note_type)
    end
  
    should have_many :products    
    should have_many :people
    should have_many :organizations
    should have_many :contributions        
    
  end
end
