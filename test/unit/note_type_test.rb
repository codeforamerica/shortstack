require 'test_helper'

class NoteTypeTest < ActiveSupport::TestCase
  context "Note Type " do
    setup do
      Factory(:note_type)
    end
  
    should have_many :notes
  end
end
