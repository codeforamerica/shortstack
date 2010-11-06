require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  should "be valid" do
    assert Note.new.valid?
  end
end
