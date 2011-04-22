require 'twitalysis/twitalysis'
class TwitterStat < ActiveRecord::Base
  acts_as_twitter_stat
end
