require 'twitalysis/twitalysis'
class Link < ActiveRecord::Base
  # default_scope order("created_at ASC")
  belongs_to :link_type
  belongs_to :linkable, :polymorphic => true
  has_one :organization, :foreign_key => 'linkable_id'


  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  after_update :update_contribution
  after_create :create_contribution

  acts_as_twitalyzable :link_url

  scope :twitter, lambda {
    select('links.*, organizations.name AS "links.org_name", lstat.screen_name AS "links.screen_name", lstat.followers_count AS "links.followers_count", lstat.following_count AS "links.following_count", lstat.statuses_count AS "links.statuses_count"')
      .where(:link_type_id => self.twitter_link_type)
      .where('lstat.created_at = (SELECT MAX(created_at) FROM twitter_stats AS max_stats WHERE max_stats.link_id = links.id)')
      .joins('INNER JOIN twitter_stats AS lstat ON lstat.link_id = links.id')
      .joins('INNER JOIN organizations ON links.linkable_type = "Organization" AND links.linkable_id = organizations.id')
  }

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

  # twitter stuff
  @@sortable_columns = ['screen_name', 'org_name', 'followers_count', 'following_count', 'statuses_count'].freeze
  @@sortable_directions = ['asc', 'desc'].freeze

  def self.sortable_columns
    @@sortable_columns
  end

  def self.sortable_directions
    @@sortable_directions
  end

  def latest_stat
    @latest_stat ||= TwitterStat.where(:screen_name => latest_stat_screen_name).order('created_at DESC').first
  end


  def self.sortable(column, direction)
    column = case column
             when 'org_name'
               'organizations.name'
             else
               'lstat.' + column
             end
    order(column + " " + direction)
  end

  def self.twitter_link_type
    LinkType.select('id').where(:name => 'Twitter').first.id
  end
  
end
