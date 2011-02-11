require 'digest/md5'

class User < ActiveRecord::Base
  has_many :authentications
  has_many :contributions
  has_one :profile
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :profile, :screen_name
  accepts_nested_attributes_for :profile
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def picture(opts = {})
    # for now just returns a gravatar, put in place for the future
    return gravatar(opts)
  end

  def gravatar(opts)
    hash = Digest::MD5.hexdigest(self.email.downcase)
    size = opts[:size]

    return "https://secure.gravatar.com/avatar/#{hash}.jpg?d=mm&s=#{size.to_s}"
  end

  def screen_name
    profile.name if profile
  end

  def screen_name=(name)
    if profile
      profile.name = name
    else
      profile = build_profile(:name => name)
    end
  end
end
