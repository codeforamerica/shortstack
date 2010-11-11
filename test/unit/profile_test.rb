require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  context "Profile " do
    setup do
      Factory(:profile)
    end
  
    should belong_to :user
    should validate_presence_of :name

  end
end
