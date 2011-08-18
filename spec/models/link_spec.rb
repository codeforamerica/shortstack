require 'spec_helper'

describe Link do
  before do
    @facebook = FactoryGirl.build(:facebook)
    @twitter = FactoryGirl.build(:twitter_link)
  end

  context "twitter functions" do
    it "should get the right username" do
      @twitter.get_tweeter.should == "rockymeza"
    end
    it "should find and store tweets" do
      @twitter.grab_tweets(1).should == true
      @twitter.update_tweets.should == true
      Tweet.all.first.data.should == Twitter.user_timeline(@twitter.get_tweeter, :trim_user =>true).first
    end
  end

  context "facebook funtions" do
    it "should find and store wall posts" do
      @facebook.grab_facebook_stats
      @facebook.update_wall.should == true
      FacebookPost.all.first.summary.should ==
        Feedzirra::Feed.fetch_and_parse("http://www.facebook.com/feeds/page.php?format=rss20&id=" + @facebook.facebook_stats.first.facebook_id.to_s).first.summary
    end
  end

end
