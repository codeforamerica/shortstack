require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  context "Link " do
    setup do
      Factory(:link)
    end
  
    should belong_to :linkable

  end
end
