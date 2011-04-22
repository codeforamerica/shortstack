require 'twitalysis/twitalysis'
class Link < ActiveRecord::Base
  # default_scope order("created_at ASC")
  belongs_to :link_type
  belongs_to :linkable, :polymorphic => true
  has_one :twitter_summary
  has_one :facebook_summary  
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :facebook_stats
  after_update :update_contribution
  after_create :create_contribution

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
    LinkType.select('id').where(:name => 'Twitter').first.id
  end
  
end
