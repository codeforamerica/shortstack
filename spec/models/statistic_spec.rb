require File.dirname(__FILE__) + '/../spec_helper'

describe Statistic do
  it "should be valid" do
    Statistic.new.should be_valid
  end
end
