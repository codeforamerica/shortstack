class Product < ActiveRecord::Base

  has_many :notes, :as => :noteable, :class_name => "Note", :dependent => :destroy
  has_many :contributions, :as => :contributable, :class_name => "Contribution", :dependent => :destroy
  has_many :whisks, :as => :whiskable, :class_name => "Whisk", :dependent => :destroy  
  has_many :parents, :as => :parentable, :class_name => "Relationship", :dependent => :destroy
  has_many :children, :as => :childable, :class_name => "Relationship", :dependent => :destroy      
  has_many :links, :as => :linkable, :class_name => "Link", :dependent => :destroy
  has_many :contacts, :as => :contactable, :class_name => "Contact", :dependent => :destroy
  has_many :addresses, :as => :addressable, :class_name => "Address", :dependent => :destroy

  accepts_nested_attributes_for :contacts
  accepts_nested_attributes_for :links
  accepts_nested_attributes_for :addresses    
  accepts_nested_attributes_for :notes
  accepts_nested_attributes_for :parents
  accepts_nested_attributes_for :children  

  scope :alpha, order("LOWER(name) ASC")  
  scope :recent, order("created_at DESC")    
  
  after_create :create_contribution
  after_update :update_contribution
  
  acts_as_taggable

  searchable do
    text :name, :default_boost => 2
    integer :id
    time :updated_at
  end
  
  def create_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Create")
  end
  
  def update_contribution
    self.contributions << Contribution.new(:user =>$current_user, :action => "Update")
  end
  
  def whisk_cities
    #grab all cities
    orgtype = OrgType.where(:name => "City").first
    orgs = Organization.where(:org_type_id => orgtype.id)
    countdown = orgs.size
    orgs.each do |org|
    puts "#{org.name}, #{org.id}"
      s = WhiskBatter.new(org)
      s.check_for_product(self)
      countdown = countdown - 1
      puts countdown
    end
  end

  def sync_crunchbase(c)
    # contacts
    contact = {
      :phone => c['phone_number'],
      :email => c['email_address'],
      :twitter => c['twitter_username'],
    }
    contacts.build(contact) if not_nil(contact) && contacts.where(contact).count == 0 

    # addresses
    for o in c['offices']
      address = {
        :address => c['address1'],
        :city => c['city'],
        :state => c['state'],
        :zipcode => c['zip_code'],
        :country => c['country_code'],
        :lat => c['latitude'],
        :long => c['longitude'],
      }
      
      addresses.build(address) if not_nil(address) && addresses.where(:address => address['address']).count == 0
    end
    
    # links
    l = [
      {:link_url => c['homepage_url'], :link_type_id => 3, :name => 'Homepage'},
      {:link_url => c['blog_url'], :link_type_id => 1, :name => 'Blog'},
    ]
    for link in l
      links.build(link) if not_nil(link) && links.where(:link_type_id => link[:link_type_id]).count == 0
    end
    # notes
    if c['overview']
      note = notes.where(:note_type_id => 5).first || notes.build(:note_type_id => 5)
      note.name = "Crunchbase"
      note.note = c['overview']
    end

    return self
  end

  def sync_crunchbase!(c)
    sync_crunchbase(c).save
  end

  def not_nil(hash)
    hash.select { |k, v|
      !v.nil?
    }.size > 0
  end
end
