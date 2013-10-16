class AppealsController < ApplicationController
  before_filter :authenticate_user!
  
  active_scaffold :appeal do |conf|
    conf.actions = [:list, :search]
    
    conf.columns = [:term, :final_status, :appeal_status, :major, :classification, :uin, :last_name, :first_name]
    
    conf.list.sorting = [{:major => :asc}, {:classification => :asc}, {:last_name => :asc}, {:first_name => :asc }]
    conf.list.per_page = 25
    
    conf.actions.swap :search, :field_search
    conf.field_search.columns = :final_status, :appeal_status, :major, :classification, :uin, :last_name, :first_name

    conf.columns[:uin].label = "UIN"
    conf.columns[:final_status].label = "Final Status"
    conf.columns[:appeal_status].label = "Appeal Status"
    conf.columns[:last_name].label = "Last Name"
    conf.columns[:first_name].label = "First Name"
    
    conf.action_links.add :grant, :type => :member, :crud_type => :update, :method => :put, :position => false
    conf.action_links.add :deny, :type => :member, :crud_type => :update, :method => :put, :position => false
  end
  
  def grant
    process_action_link_action do |record|
      self.successful = true
      record.update_attribute(:appeal_status, "Granted")
    end
  end
  
  def deny
    process_action_link_action do |record|
      self.successful = true
      record.update_attribute(:appeal_status, "Denied")
    end    
  end
  
end
