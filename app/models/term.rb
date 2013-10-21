class Term < ActiveRecord::Base
  attr_accessible :code, :name, :probation_term
  
  has_many :students, dependent: :destroy
  
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
  
  def self.deactivate_all
    Term.where('active = ?', true).update_all("active = 'false'")
  end
  
end
