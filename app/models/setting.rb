class Setting < ActiveRecord::Base
  attr_accessible :name, :setting
  scope :twitter_key, where(:name => "twitter_key")
  scope :twitter_secret, where(:name => "twitter_secret")
  scope :facebook_key, where(:name => "facebook_key")
  scope :facebook_secret, where(:name => "facebook_secret")
  scope :github_key, where(:name => "github_key")
  scope :github_secret, where(:name => "github_secret")
end
