require 'open-uri'
require 'json'

module Twitalysis

  class Cached
    attr_accessor :method, :handle
    def initialize(handle)
      # @db = CouchRest.database!(@db_name)
      @method = self.class.name.split('::').last.downcase.to_sym
      @handle = handle

      @doc = nil
    end

    # def get
    #   @doc = begin
    #     get_from_couch
    #   rescue RestClient::ResourceNotFound
    #     get_from_twitter
    #   end
    # end

    # def get_from_couch
    #   @db.get(@handle)
    # end

    def get_from_twitter
      Twitter.__send__(@method, @handle)
    end

    def get_census
      url = Twitalysis.census_url(@handle)
      JSON.parse open(url, "User-Agent" => "Ruby-Wget").read
    end

    # def cache
    #   CouchRest.put "#{@db.root}/#{@handle}", @doc
    # end

    class << self
      def from_link(link)
        self.new(Twitalysis.link_to_handle(link))
      end
    end
  end

  class User < Cached
    def initialize(*args)
      # @db_name = 'twitters'
      super *args
    end
  end
  
  module Acts
    module Twitalyzable

      # takes a column_name for a link to a twitter_profile
      def acts_as_twitalyzable(column)
        class_eval <<-RUBY
          has_many :twitter_stats
          has_many :twitter_censuses

          # grabs the twitter user information for a twitter user
          # based on the column passed into acts_as_twitalyzable
          # currently, the column is assumed to be a link to a twitter profile
          # and is treated as such
          #
          # adds a new entry to the twitter_stats collection
          def twitalyze
            begin
              stat = Twitalysis::User.from_link(#{column.to_s}).get_from_twitter
              twitter_stats << TwitterStat.from_twitalysis(stat)
            rescue
              self.upflag
            end

            twitter_stats
          end

          def twitalyze!
            twitalyze

            save
          end

          def do_census
            begin
              census = Twitalysis::User.from_link(#{column.to_s}).get_census
              twitter_censuses << TwitterCensus.from_hash(census)
            rescue
              self.upflag
            end

            twitter_censuses
          end

          def do_census!
            do_census
            save
          end

          def latest_stats
            if instance_variables.include? :@twitter_stats
              twitter_stats.first
            else
              twitter_stats.order("created_at DESC").first
            end
          end
        RUBY
      end

      def acts_as_twitter_stat
        class_eval do
          belongs_to :link

          # translates some keys and then applies them to a new instance
          # of TwitterStat
          def self.from_twitalysis(twitalysis)
            ts = self.new

            Twitalysis::TwitterStateTrash.new(twitalysis).each_pair do |key, value|
              ts[key] = value
            end

            ts
          end
        end
      end

      def acts_as_twitter_census
        class_eval do
          belongs_to :link

          def self.from_hash(hash)
            census = self.new
            census.attributes.keys.each do |key|
              census[key] = hash[key]
            end

            census
          end
        end
      end
    end
  end

  class TwitterStateTrash < Hashie::Trash
    property :created, :from => :created_at
    property :description
    property :following_count, :from => :friends_count
    property :followers_count
    property :following_count
    property :geo_enabled
    property :listed_count
    property :profile_background_color
    property :profile_background_image_url
    property :profile_background_tile
    property :profile_image_url
    property :profile_link_color
    property :profile_sidebar_border_color
    property :profile_sidebar_fill_color
    property :profile_text_color
    property :screen_name
    property :statuses_count
    property :time_zone
    property :url
    property :verified

    def property_exists?(property)
      self.class.property?(property.to_sym)
    end
  end


  # module methods
  def self.link_to_handle(link)
    link.match(/https?:\/\/(?:www\.)?twitter.com\/([^\/]+).*/)[1]
  end

  def self.census_key
    ENV['INFOCHIMPS_API_KEY']
  end

  def self.census_url(handle)
    "http://api.infochimps.com/social/network/tw/influence/metrics?apikey=#{Twitalysis.census_key}&screen_name=" + handle
  end
end



ActiveRecord::Base.extend Twitalysis::Acts::Twitalyzable
