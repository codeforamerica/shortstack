require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "Various user tests" do
    setup do
      @user = Factory(:user)
    end
    
    should_have_many :authentications
    
  end
end
