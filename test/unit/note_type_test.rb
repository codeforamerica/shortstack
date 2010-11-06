require 'test_helper'

class NoteTypeTest < ActiveSupport::TestCase
  should "be valid" do
    assert NoteType.new.valid?
  end
end
