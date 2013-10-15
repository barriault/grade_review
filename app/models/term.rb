class Term < ActiveRecord::Base
  attr_accessible :active, :code, :name, :probation_term
  before_save :deactivate_all_others
  before_create :deactivate_all_others
  
  def to_label
    "#{code}"
  end
  
  def self.current
    where('active = ?', true).first
  end
  
  def is_spring?
    !code.match('12$').nil?
  end
  
  def is_summer?
    !code.match('22$').nil?
  end
  
  def is_fall?
    !code.match('32$').nil?
  end
  
private
  
  def deactivate_all_others
    self.class.where('active = ?', true).update_all("active = 'false'") if self.active?
  end
  
end
