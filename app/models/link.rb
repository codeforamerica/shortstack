require 'twitalysis/twitalysis'
class Link < ActiveRecord::Base
  # default_scope order("created_at ASC")
  belongs_to :link_type
  belongs_to :linkable, :polymorphic => true
  has_many :statistics, :as => :statisticable, :class_name => "Statistic", :dependent => :destroy
  has_one :twitter_summary, :dependent => :destroy
  has_one :facebook_summary, :dependent => :destroy
  has_many :facebook_stats, :dependent => :destroy
  has_many :tweets
  scope :website, joins(:link_type).where("link_types.name = 'website'")

  acts_as_twitalyzable :link_url

  def grab_facebook_stats
    self.facebook_stats.new.save_facebook_data
  end

  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end

  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end

  def check_for_redirect
    response = nil
    response = Net::HTTP.start(link_url.gsub("http://", "").gsub("/", ""), 80).head('/')
    if !response.nil? and response.code == "302"
      self.update_attributes(:link_url => response["location"])
    end
  end

  def licenses
    { "gpl2"=> ['GNU GPL v2','http://www.gnu.org/licenses/gpl2.html'],
      "gpl3"=> ['GNU GPL v3','http://www.gnu.org/licenses/gpl-3.0.html'],
      "lgpl"=> ['GNU Lesser GPL','http://www.gnu.org/licenses/lgpl.html'],
      "mit"=> ['MIT License','http://opensource.org/licenses/mit-license'],
      "mpl11"=> ['Mozilla Public License 1.1','http://www.mozilla.org/MPL/'],
      "bsd"=> ['New BSD License','http://www.opensource.org/licenses/bsd-license.php'],
      "asf20"=> ['Apache License 2.0','http://www.apache.org/licenses/LICENSE-2.0.html'],
      "epl"=> ['Eclipse Public License 1.0','http://www.eclipse.org/legal/epl-v10.html']
    }
  end

  def self.twitter_link_type
    LinkType.select('id').where(:name => 'twitter').first.id
  end

  def self.website_link_type
    LinkType.select('id').where(:name => 'website').first.id
  end

  # pulls in tweets by the page (of 200).
  # returns false if no tweets found, 0 if there is no need to
  # pull the next page of tweets. should therefore be called
  # with while(grab_tweets(i) != 0) do i +=1 end
  def grab_tweets(page)
    tweeter = self.get_tweeter
    found_tweets = false

    all_tweets = Twitter.user_timeline(tweeter, :trim_user => true, :count => 200, :include_rts => true, :page => page)

    unless all_tweets.empty?
      if all_tweets.size < 200
        found_tweets = 0
      else
        found_tweets = true
      end

      if page == 1
        first_tweet = all_tweets.shift
        Tweet.new(:data => first_tweet, :is_latest => true, :link_id => self.id, :created_at => first_tweet.created_at.to_time).save
      end

      for item in all_tweets do
        Tweet.new(:data => item, :link_id => self.id, :created_at => item.created_at.to_time).save
      end
    end
    return found_tweets
  end

  #add an hour to a grab_tweets delayed job
  def add_hour_to_delayed_jobs
    Delayed::Job.where("handler LIKE '%grab_tweets%'").each { |x| x.update_attributes(:run_at => Time.now + 1.hour)}
  end


  # pulls in all tweets tweeted since the previous most-recent.
  # example: link.delay.update_tweets
  def update_tweets
    updated = false
    tweeter = self.get_tweeter
    latest_tweet = Tweet.all(:is_latest => true, :link_id => self.id).first

    new_tweets = Twitter.user_timeline(tweeter, :since_id => latest_tweet.data["id"], :trim_user => true)

    unless new_tweets.empty?
      first_tweet = new_tweets.shift
      Tweet.new(:data => first_tweet, :is_latest => true, :link_id => self.id, :created_at => first_tweet.created_at.to_time).save
      latest_tweet.is_latest = false
      latest_tweet.save

      for item in new_tweets do
        Tweet.new(:data => item, :link_id => self.id, :created_at => item.created_at.to_time).save
      end

      updated = true
    end

    return updated
  end

  # uses facebook's graph to find a wall's rss feed, then feedzirra
  # to pull the updates; returns false if no new data
  def update_wall
    id = self.facebook_stats.first.facebook_id
    new_posts = Feedzirra::Feed.fetch_and_parse("http://www.facebook.com/feeds/page.php?format=rss20&id=" + id.to_s)
    latest_post = FacebookPost.all(:is_latest => true, :link_id => self.id).first
    found_posts = false
    first_post = new_posts.entries.shift

    unless latest_post.nil?
      if a.firstfirst_post.entry_id == latest_post.entry_id
        return found_posts
      else
        FacebookPost.create(:is_latest => true, :link_id => self.id,  :entry_id => item.entry_id, :title => item.title,
              :url => item.url, :summary => item.summary, :published => item.published.to_time, :author => item.author)
        found_posts = true
      end
    end

    for item in new_posts.entries do
      if !latest_post.nil? && item.entry_id == latest_post.entry_id then break
        end
      FacebookPost.create(:link_id => self.id,  :entry_id => item.entry_id, :title => item.title, :url => item.url,
        :summary => item.summary, :published => item.published.to_time, :author => item.author)
    end
    return found_posts
  end


  def get_tweeter
    blah = self.link_url.split("/")
    i = 0
    until(blah[i] == "twitter.com") do i +=1 end
    if blah[i+1] == "#!" then return blah[i+2]
    else return blah[i+1] end
    return false
  end


  def after_creation
    if link_type_id = Link.website_link_type
      WhiskBatter.new(linkable).delay.associate_social_links :twitter
      WhiskBatter.new(linkable).delay.associate_social_links :facebook
    end
  end

  def upflag
    f = flag || 0
    update_attributes(:flag => f + 1)
  end
end
