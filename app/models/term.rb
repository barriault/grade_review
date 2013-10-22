class Term < ActiveRecord::Base
  attr_accessible :code, :name, :probation_term, :total_undergraduate_enrollment
  
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
  
  def suspensions
    students.where(Student.arel_table[:final_status].matches("%Suspension%")).count
  end
  
  def probations
    students.where(Student.arel_table[:final_status].matches("%Probation%")).count
  end
  
  def total_deficiency
    students.where(Student.arel_table[:final_status].matches("%Probation%").or(Student.arel_table[:final_status].matches("%Suspension%"))).count
  end
  
  def percent_of_total
    total_deficiency.to_f / total_undergraduate_enrollment.to_f
  end
  
  def appeals
    students.where(Student.arel_table[:appeal_status].not_eq(nil)).count
  end
  
  def appeals_granted
    students.where(:appeal_status => "Granted").count
  end
  
  def appeals_denied
    students.where(:appeal_status => "Denied").count
  end
  
  def majors
    (students.collect { |student| student.major }).uniq.sort
  end
  
  def suspensions_by_major(major)
    students.where(major: major).where(Student.arel_table[:final_status].matches("%Suspension%")).count
  end
  
  def probations_by_major(major)
    students.where(major: major).where(Student.arel_table[:final_status].matches("%Probation%")).count
  end
  
  def total_deficiency_by_major(major)
    students.where(major: major).where(Student.arel_table[:final_status].matches("%Probation%").or(Student.arel_table[:final_status].matches("%Suspension%"))).count
  end
  
  def appeals_by_major(major)
    students.where(major: major).where(Student.arel_table[:appeal_status].not_eq(nil)).count
  end
  
  def appeals_granted_by_major(major)
    students.where(major: major).where(:appeal_status => "Granted").count
  end
  
  def appeals_denied_by_major(major)
    students.where(major: major).where(:appeal_status => "Denied").count
  end
  
end
