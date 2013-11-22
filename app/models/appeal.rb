class Appeal < ActiveRecord::Base
  self.table_name = "students"
  
  attr_accessible :appeal_status, :recommended_appeal_status
    
  belongs_to :term
  
  default_scope { where(arel_table[:final_status].matches("%Suspension%").or(arel_table[:appeal_status].not_eq(nil))) }
  default_scope { where(:term_id => Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}]"
  end
  
  def undo_appeal
    if appeal_status
      update_attribute(:appeal_status, nil)
      if Term.current.is_summer?
        update_attribute(:final_status, "SAIL Suspension")
      else
        if initial_status.eql?("Suspension")
          update_attribute(:final_status, "Suspension")
        else
          update_attribute(:final_status, "Departmental Suspension")
        end
      end
    end
  end
  
  def grant_appeal
    update_attribute(:appeal_status, "Granted")
    if Term.current.is_summer?
      update_attribute(:final_status, "SAIL Probation")
    else
      update_attribute(:final_status, "Probation")
    end
  end
  
  def deny_appeal
    update_attribute(:appeal_status, "Denied")
    if Term.current.is_summer?
      update_attribute(:final_status, "SAIL Suspension")
    else
      if initial_status.eql?("Suspension")
        update_attribute(:final_status, "Suspension")
      else
        update_attribute(:final_status, "Departmental Suspension")
      end
    end
    
  end
  
end