require File.dirname(__FILE__) + '/../spec_helper'

describe StatisticType do
  it "should be valid" do
    StatisticType.new.should be_valid
  end
end
