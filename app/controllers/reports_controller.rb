class ReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def alpha_roster
    @students = Student.accessible_by(current_ability)
      .order(:last_name, :first_name)
    respond_to do |format|
      format.csv { send_data @students.alpha_roster }
      format.html
    end
  end
  
  def probation_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Probation")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def probation_level_1_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Probation Level 1")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def probation_level_2_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Probation Level 2")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def suspension_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Suspension")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def departmental_suspension_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Departmental Suspension")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def campus_suspension_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Campus Suspension")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def sail_good_standing_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "SAIL Good Standing")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def sail_probation_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "SAIL Probation")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def sail_suspension_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "SAIL Suspension")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def gateway_good_standing_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Gateway Good Standing")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def gateway_probation_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Gateway Probation")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def gateway_suspension_merge_data
    @students = Student.accessible_by(current_ability)
      .where(:final_status => "Gateway Suspension")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.merge_data }
    end
  end
  
  def removal_from_tamu_suspension
    @students = Student.accessible_by(current_ability)
      .where("initial_status = 'Suspension' AND (final_status = 'Probation Level 1' OR final_status = 'Probation Level 2' OR final_status = 'Departmental Suspension' OR final_status = 'Campus Suspension') AND appeal_status IS NULL")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
      format.html
    end
  end
  
  def tamu_suspensions
    @students = Student.accessible_by(current_ability)
      .where("initial_status = 'Suspension' AND final_status = 'Suspension'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
      format.html
    end
  end
  
  def departmental_suspensions
    @students = Student.accessible_by(current_ability)
      .where("final_status = 'Departmental Suspension'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
      format.html
    end
  end
  
  def campus_suspensions
    @students = Student.accessible_by(current_ability)
      .where("final_status = 'Campus Suspension'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
      format.html
    end
  end
  
  def appeals
    @students = Student.accessible_by(current_ability)
      .where("appeal_status = 'Denied' OR appeal_status = 'Granted'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
      format.html
    end
  end
  
  def scholastic_deficiency_by_term
    @terms = Term.order("code DESC")
  end
  
  def scholastic_deficiency_by_major
    @term = Term.find(params[:id])
  end
  
  def users
    @users = User.accessible_by(current_ability)
    
    respond_to do |format|
      format.csv { send_data @users.users_report }
      format.html
    end
  end
  
end
