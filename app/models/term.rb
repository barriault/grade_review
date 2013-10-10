class Term < ActiveRecord::Base
  attr_accessible :active, :code, :name
  before_save :deactivate_all_others
  before_create :deactivate_all_others
  
  def to_label
    "#{code}"
  end
  
  def self.current
    where('active = ?', true).first
  end
  
private
  
  def deactivate_all_others
    self.class.where('active = ?', true).update_all("active = 'false'") if self.active?
  end
  
end
