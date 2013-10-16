class StudentsController < ApplicationController
  before_filter :authenticate_user!
  
  active_scaffold :student do |conf|
    conf.columns = [:initial_status, :final_status, :uin, :major, :classification, :last_name, :first_name, :address_1, :address_2, :city, :state, :postal_code, 
      :email, :degree_candidate, :cum_overall_gpa_hrs, :cum_institution_gpa, :var_cum_qpts, :var_term_qpts, :term_institution_gpa_hrs, 
      :term_institution_gpa, :first_term, :phone_number, :emailed]
    conf.list.columns = [:term, :initial_status, :final_status, :degree_candidate, :major, :classification, :uin, :last_name, :first_name,
      :cum_overall_gpa_hrs, :cum_institution_gpa, :var_cum_qpts, :var_term_qpts, :term_institution_gpa_hrs, :term_institution_gpa, :first_term, :emailed]
    conf.update.columns = [:final_status]
    conf.list.sorting = [{ :initial_status => :asc}, {:major => :asc}, {:classification => :asc}, {:last_name => :asc}, {:first_name => :asc }]
    conf.list.per_page = 25
    conf.actions.swap :search, :field_search
    conf.field_search.columns = :initial_status, :final_status, :major, :classification, :uin, :last_name, :first_name, :emailed
    conf.action_links.add :send_emails, :type => :collection, :method => :put, :params => {:emailed => false}, :position => false
    conf.action_links.add :approve, :type => :member, :crud_type => :update, :method => :put, :position => false
    # conf.action_links.add :change, :type => :member, :crud_type => :update, :method => :put, :position => false
    # conf.action_links.add :remove, :type => :member, :crud_type => :update, :method => :put, :position => false
    
    conf.columns[:initial_status].label = "Initial Status"
    conf.columns[:final_status].label = "Final Status"
    conf.columns[:degree_candidate].label = "Deg Cand?"
    conf.columns[:classification].label = "Class"
    conf.columns[:uin].label = "UIN"
    conf.columns[:last_name].label = "Last Name"
    conf.columns[:first_name].label = "First Name"
    conf.columns[:cum_overall_gpa_hrs].label = "Cum OA GPA Hrs"
    conf.columns[:cum_institution_gpa].label = "Cum Instn GPA"
    conf.columns[:var_cum_qpts].label = "Var Cum Qpts"
    conf.columns[:var_term_qpts].label = "Var Term Qpts"
    conf.columns[:term_institution_gpa_hrs].label = "Term Instn GPA Hrs"
    conf.columns[:term_institution_gpa].label = "Term Instn GPA"
    conf.columns[:first_term].label = "First Term?"
  end
  
  def send_emails
    process_action_link_action do
      self.successful = true
      each_record_in_page { |record| 
        unless record.emailed
          record.send_email
          record.update_attribute(:emailed, true)
        end
      }
    end
  end
  
  def approve
    process_action_link_action do |record|
      self.successful = true
      record.update_attribute(:final_status, record.initial_status)
    end
  end
  
  def change
    process_action_link_action do |record|
      self.successful = true
      if record.initial_status.eql?("Probation")
        record.update_attribute(:final_status, "Dept Susp")
      else
        record.update_attribute(:final_status, "Probation")
      end
    end
  end
  
  def remove
    process_action_link_action do |record|
      self.successful = true
      record.update_attribute(:final_status, "Removed")
    end
  end
  
  def import
    if params[:file]
      Student.import(params[:file])
      redirect_to students_url, notice: "Students imported."
    else
      redirect_to students_path, alert: "Please select a file."
    end
  end  
  
  def remove_all
    Student.delete_all
    redirect_to students_path, notice: "All students removed from database."
  end
  
end
