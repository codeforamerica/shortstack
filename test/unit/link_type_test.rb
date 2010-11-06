require 'test_helper'

class LinkTypeTest < ActiveSupport::TestCase
  should "be valid" do
    assert LinkType.new.valid?
  end
end
