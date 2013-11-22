class AppealRecommendation < ActiveRecord::Base
  self.table_name = "students"
  
  attr_accessible :appeal_status, :recommended_appeal_status
    
  belongs_to :term
  
  default_scope { where(arel_table[:final_status].matches("%Suspension%").or(arel_table[:appeal_status].not_eq(nil))) }
  default_scope { where(:term_id => Term.current.id) }
  
  def to_label
    "#{first_name} #{last_name} [#{uin}]"
  end
  
  def undo_appeal
    if appeal_status.present?
      update_attribute(:recommended_appeal_status, nil)
    end
  end
  
  def grant_appeal
    update_attribute(:recommended_appeal_status, "Grant")
  end
  
  def deny_appeal
    update_attribute(:recommended_appeal_status, "Deny")
  end
end
