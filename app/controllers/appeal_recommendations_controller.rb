class AppealRecommendationsController < ApplicationController
  before_filter :authenticate_user!
  
  active_scaffold :appeal_recommendation do |conf|
    conf.actions = [:list, :search]
    
    conf.columns = [:term, :final_status, :recommended_appeal_status, :appeal_status, :major, :classification, :uin, :last_name, :first_name]
    
    conf.list.sorting = [{:major => :asc}, {:classification => :asc}, {:last_name => :asc}, {:first_name => :asc }]
    conf.list.per_page = 25
    
    conf.actions.swap :search, :field_search
    conf.field_search.columns = :final_status, :recommended_appeal_status, :appeal_status, :major, :classification, :uin, :last_name, :first_name

    conf.columns[:uin].label = "UIN"
    conf.columns[:final_status].label = "Final Status"
    conf.columns[:recommended_appeal_status].label = "Recom'd Appeal Status"
    conf.columns[:major].label = "Program"
    conf.columns[:appeal_status].label = "Appeal Status"
    conf.columns[:last_name].label = "Last Name"
    conf.columns[:first_name].label = "First Name"
    
    conf.action_links.add :grant, :type => :member, :crud_type => :update, :method => :put, :position => false
    conf.action_links.add :deny, :type => :member, :crud_type => :update, :method => :put, :position => false
    conf.action_links.add :undo, :type => :member, :crud_type => :update, :method => :put, :position => false
  end
  
  def undo
    process_action_link_action do |record|
      self.successful = true
      record.undo_appeal
    end
  end
  
  def grant
    process_action_link_action do |record|
      self.successful = true
      record.grant_appeal
    end
  end
  
  def deny
    process_action_link_action do |record|
      self.successful = true
      record.deny_appeal
    end    
  end
  
end
