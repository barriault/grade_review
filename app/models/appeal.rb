class Appeal < ActiveRecord::Base
  self.table_name = "students"
  
  attr_accessible :appeal_status
    
  belongs_to :term
  
  default_scope { where(arel_table[:final_status].matches("%Suspension%")) }
  default_scope { where(:term_id => Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}]"
  end
end