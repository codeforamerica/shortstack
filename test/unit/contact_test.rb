require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  context "Contact " do
    setup do
      Factory(:contact)
    end
  
  should belong_to :contactable
  
  end
end
