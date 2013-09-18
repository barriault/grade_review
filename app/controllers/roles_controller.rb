class RolesController < ApplicationController
  
  active_scaffold :role do |config|
    config.label = "All Roles"
    config.columns = [:name]
    list.sorting = {:created_at => 'DESC'}
  end
  
end