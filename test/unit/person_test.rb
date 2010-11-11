require 'test_helper'

class PersonTest < ActiveSupport::TestCase

  context "Person " do
    setup do
      Factory(:person)
    end
  
    should have_many :links
    should have_many :notes
    should have_many :contributions
    should have_many :addresses
    should have_many :relationships
    should have_many :products    
    should have_many :organizations
    
    should validate_presence_of :name

  end

end
