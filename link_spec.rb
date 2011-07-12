require 'spec_helper'

describe Link do
  before do
    @twitter_link = FactoryGirl.build(:twitter_link)
    @facebook_link = FactoryGirl.build(:facebook)

  describe '#get_tweeter' do
    it '#should throw no errors' do
      expect { @twitter_link.get_tweeter }.to_not raise_error
    end

    it 'should get correct user' do
      twitter_link.get_tweeter.should == 'rockymeza'
    end
  end
