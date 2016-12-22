class StudentsController < ApplicationController
  before_filter :authenticate_user!
  
  active_scaffold :student do |conf|
    conf.columns = [:initial_status, :final_status, :appeal_status, :uin, :major, :classification, :last_name, :first_name, :address_1, :address_2, :city, :state, :postal_code, 
      :email, :degree_candidate, :cum_overall_gpa_hrs, :cum_institution_gpa, :var_cum_qpts, :var_term_qpts, :term_institution_gpa_hrs, 
      :term_institution_gpa, :first_term, :phone_number, :emailed]
    conf.list.columns = [:term, :initial_status, :final_status, :degree_candidate, :major, :classification, :uin, :last_name, :first_name,
      :cum_overall_gpa_hrs, :cum_institution_gpa, :var_cum_qpts, :var_term_qpts, :term_institution_gpa_hrs, :term_institution_gpa, :admit_status, :admit_type, :emailed]
    conf.update.columns = [:final_status]
    conf.list.sorting = [{ :initial_status => :asc}, {:major => :asc}, {:classification => :asc}, {:last_name => :asc}, {:first_name => :asc }]
    conf.list.per_page = 25
    conf.actions.swap :search, :field_search
    conf.field_search.columns = :initial_status, :final_status, :appeal_status, :major, :classification, :uin, :last_name, :first_name, :admit_status, :admit_type, :emailed
    conf.action_links.add :approve, :type => :member, :crud_type => :update, :method => :put, :position => false
    
    conf.actions.exclude :show
    conf.actions.exclude :delete
    conf.actions.exclude :create
    
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
    conf.columns[:admit_status].label = "AS"
    conf.columns[:admit_type].label = "AT"
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
      if record.initial_status.eql?("Probation Level 1")
        record.update_attribute(:final_status, "Dept Susp")
      else
        record.update_attribute(:final_status, "Probation Level 1")
      end
    end
  end
  
  def remove
    process_action_link_action do |record|
      self.successful = true
      record.update_attribute(:final_status, "Removed")
    end
  end
  
end
