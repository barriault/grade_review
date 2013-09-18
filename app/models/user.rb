class User < ActiveRecord::Base
  rolify
  attr_accessible :name, :email, :uid, :role_ids
  
  validates :name, :presence => true
  validates :uid, :presence => true
  validates :email, :presence => true, :email => true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
    end
  end

end
