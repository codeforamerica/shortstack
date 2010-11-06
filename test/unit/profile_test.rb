require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  should "be valid" do
    assert Profile.new.valid?
  end
end
