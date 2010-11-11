require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  context "Note " do
    setup do
      Factory(:note)
    end
  
    should belong_to :noteable
  end
end
