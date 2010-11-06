require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  should "be valid" do
    assert Link.new.valid?
  end
end
