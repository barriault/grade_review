class RolesController < ApplicationController
  
  before_filter :authenticate_user!
  
  active_scaffold :role do |config|
    config.label = "All Roles"
    config.columns = [:name]
    list.sorting = {:created_at => 'DESC'}
  end
  
end