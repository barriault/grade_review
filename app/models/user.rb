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

  def self.users_report(options = {})
    CSV.generate(options) do |csv|
      csv << ["Name", "Email", "Roles"]
      
      all.each do |user|
        roles = user.roles.map {|r| r.name.titleize.upcase}.join(", ") unless user.roles.first.nil?
        csv << [user.name, user.email, roles]
      end
    end
  end
end
