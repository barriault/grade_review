class Address < ActiveRecord::Base
  self.table_name = "students"
  
  attr_accessible :address_1, :address_2, :city, :postal_code, :state
    
  belongs_to :term
  
  default_scope { where(term_id: Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}]"
  end
end