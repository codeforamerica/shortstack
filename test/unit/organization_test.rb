require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase

  should validate_presence_of :name
  should belong_to :org_type


end
