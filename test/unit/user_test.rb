require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "Various user tests" do
    setup do
      @user = Factory(:user)
    end
    
    should have_many :authentications
    should have_many :contributions
    should have_one :profile        
    
  end
end
