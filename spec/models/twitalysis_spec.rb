require 'spec_helper'
require 'twitalysis/twitalysis'

describe Twitalysis do
  before do
    @twitter_link = FactoryGirl.build(:twitter_link)

    stub_request(:get, "https://api.twitter.com/1/users/show.json?screen_name=rockymeza")
     .with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Twitter Ruby Gem 1.4.1'})
     .to_return(:status => 200, :body => fixture('rockymeza.json'), :headers => {})
    stub_request(:get, Twitalysis.census_url('rockymeza'))
      .with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby-Wget'})
      .to_return(:status => 200, :body => fixture('census_rocky.json'), :headers => {})
  end

  describe Twitalysis::User do
    describe '#from_link' do
      it 'should throw no errors' do
        expect { Twitalysis::User.from_link(@twitter_link.link_url) }.to_not raise_error
      end

      it 'should create a Twitalysis::User that is ready to be populated from Twitter' do
        user = Twitalysis::User.from_link(@twitter_link.link_url)

        user.handle.should == 'rockymeza'
        user.method.should == :user
      end
    end

    describe '#get_from_twitter' do
      before do
        @user = Twitalysis::User.from_link(@twitter_link.link_url)
      end

      it 'should throw no errors' do
        expect { @user.get_from_twitter }.to_not raise_error
      end

      it 'should grab data from twitter' do
        user = @user.get_from_twitter
        user.location.should == 'Denver, CO'
      end
    end

    describe '#get_census' do
      before do
        @user = Twitalysis::User.new('rockymeza')
      end

      it 'should throw no errors' do
        expect { @user.get_census }.to_not raise_error
      end

      it 'should return a census hash' do
        census = @user.get_census

        census.class.should == Hash
        census['sway'].should == 0.0
      end
    end
  end

  describe Twitalysis::Acts do
    describe Twitalysis::Acts::Twitalyzable do
      it 'should be attached to ActiveRecord::Base' do
        ActiveRecord::Base.should respond_to :acts_as_twitalyzable
        ActiveRecord::Base.should respond_to :acts_as_twitter_stat
        ActiveRecord::Base.should respond_to :acts_as_twitter_census
      end

      describe '#twitalyze' do
        before do
          stub_request(:get, "https://api.twitter.com/1/users/show.json?screen_name=share")
            .with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Twitter Ruby Gem 1.4.0'})
            .to_return(:status => 403, :body => fixture('twitter_share.json'), :headers => {})
          @bad_link = FactoryGirl.build(:twitter_link, :link_url => 'http://twitter.com/share')
        end

        it 'should throw no errors' do
          expect {@twitter_link.twitalyze}.to_not raise_error
        end

        it 'should increase append a TwitterStat object to the Link object' do
          before = @twitter_link.twitter_stats.count
          after = @twitter_link.twitalyze.size

          after.should == before + 1
        end
        
        it 'should not save the Link' do
          before = @twitter_link.twitter_stats.count
          @twitter_link.twitalyze

          @twitter_link.twitter_stats.count.should == before
        end

        it 'should upflag it there are errors' do
          before = @bad_link.flag
          @bad_link.twitalyze

          @bad_link.flag.should == before + 1
        end
      end

      describe '#twitalyze!' do  
        before do
          @before = @twitter_link.twitter_stats.count
          @twitter_link.twitalyze!
        end

        it 'should save the link' do
          @twitter_link.twitter_stats.count.should > @before
        end

        it 'should create a TwitterSummary' do
          @twitter_link.twitter_summary.should_not == nil
        end
      end

      describe '#from_twitalysis' do
        before do
          @twitalysis = Twitalysis::User.new('rockymeza').get_from_twitter
        end

        it 'should throw no errors' do
          expect {TwitterStat.from_twitalysis(@twitalysis)}.to_not raise_error
        end

        it 'should return a new TwitterStat populated from twitter' do
          ts = TwitterStat.from_twitalysis(@twitalysis)

          ts.followers_count.should == 44
        end

        it 'should translate some columns names correctly' do
          ts = TwitterStat.from_twitalysis(@twitalysis)

          ts.following_count.should == @twitalysis.friends_count
        end
      end

      describe '#from_hash' do
        before do
          @census = Twitalysis::User.new('rockymeza').get_census
        end

        it 'should throw no errors' do
          expect {TwitterCensus.from_hash(@census)}.to_not raise_error
        end

        it 'should create a TwitterCensus object from a hash' do
          census = TwitterCensus.from_hash(@census)

          census.class.should == TwitterCensus
        end
      end

      describe '#do_census' do
        before do
          stub_request(:get, Twitalysis.census_url('bad'))
            .with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby-Wget'})
            .to_return(:status => 404, :body => '', :headers => {})
          @bad_link = Factory.build(:twitter_link, :link_url => 'http://twitter.com/bad')
        end

        it 'should append a TwitterCensus' do
          before = @twitter_link.twitter_censuses.count
          after = @twitter_link.do_census.size

          after.should == before + 1
        end

        it 'should not save the Link' do
          before = @twitter_link.twitter_censuses.count
          @twitter_link.do_census

          @twitter_link.twitter_censuses.count.should == before
        end

        it 'should upflag it there are errors' do
          before = @bad_link.flag
          expect {@bad_link.do_census}.to raise_error

          @bad_link.flag.should == before + 1
        end
      end

      describe '#do_census!' do
        it 'should not save the Link' do
          before = @twitter_link.twitter_censuses.count
          @twitter_link.do_census!

          @twitter_link.twitter_censuses.count.should == before + 1
        end

        it 'should associate itself with the TwitterSummary' do
          @twitter_link.do_census!

          @twitter_link.twitter_summary.feedness.should == 0.42857143 
        end
      end
    end
  end

  describe '#link_to_handle' do
    it 'should return the correct handle' do
      Twitalysis.link_to_handle(@twitter_link.link_url).should == "rockymeza"
    end

    it 'should work with www. prefixed URLS' do
      Twitalysis.link_to_handle('http://www.twitter.com/rockymeza').should == 'rockymeza'
    end

    it 'should work with junk on the end' do
      Twitalysis.link_to_handle('http://www.twitter.com/rockymeza/wazaa').should == 'rockymeza'
    end
  end
end
