require 'twitalysis/twitalysis'
class TwitterCensus < ActiveRecord::Base
  acts_as_twitter_census
end
