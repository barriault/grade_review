class ReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def alpha_roster
    @students = Student.accessible_by(current_ability)
      .order(:last_name, :first_name)
    respond_to do |format|
      format.csv { send_data @students.alpha_roster }
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
      .where(:final_status => "Dept Susp")
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
  
  def tamu_suspension_to_probation
    @students = Student.accessible_by(current_ability)
      .where("initial_status = 'Suspension' AND final_status = 'Probation'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
    end
  end
  
  def tamu_suspensions
    @students = Student.accessible_by(current_ability)
      .where("initial_status = 'Suspension' AND final_status = 'Suspension'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
    end
  end
  
  def departmental_suspensions
    @students = Student.accessible_by(current_ability)
      .where("initial_status = 'Probation' AND final_status = 'Departtmental Suspension'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
    end
  end
  
  def appeals
    @students = Student.accessible_by(current_ability)
      .where("appeal_status = 'Denied' OR appeal_status = 'Granted'")
      .order("major, classification, last_name, first_name")
      
    respond_to do |format|
      format.csv { send_data @students.standard_report }
    end
  end
  
  def scholastic_deficiency_by_term
    @terms = Term.order("code DESC")
  end
  
  def scholastic_deficiency_by_major
    @term = Term.find(params[:id])
  end
  
end
