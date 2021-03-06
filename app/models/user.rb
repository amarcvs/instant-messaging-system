class User < ApplicationRecord #ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,# :confirmable, #:trackable,
         :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
         

  acts_as_user :roles => [:messagewriter, :admin]

  # this create a problem with multiple type of registrations
  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end
    
  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
      unless user
        user = User.create( email: data['email'], password: Devise.friendly_token[0,20]
        )
      end
    user
  end
  
  # Possible alternative of the above function
  #def self.from_omniauth(auth)
  #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #    user.email = auth.info.email
  #    user.password = Devise.friendly_token[0,20]
  #  end
  #end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # my helper methods
  def is_admin?
    return (self.roles_mask & 2) == 2
  end

  def set_admin
    self.roles_mask = (self.roles_mask | 2) 
    self.save
  end

  def unset_admin
    self.roles_mask = (self.roles_mask & 1) 
    self.save
  end

  def is_messagewriter?
    return (self.roles_mask & 1) == 1
  end

  def is_banned?
    return self.roles_mask  == 0
  end

  def set_messagewriter
    self.roles_mask = (self.roles_mask | 1) 
    self.save
  end

  def unset_messagewriter
    self.roles_mask = 0 
    self.save
  end
  #######################
  
end