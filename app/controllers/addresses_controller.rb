class AddressesController < ApplicationController
  before_filter :authenticate_user!
  
  active_scaffold :address do |conf|
    conf.actions = [:update, :list]
    
    conf.columns = [:term, :uin, :last_name, :first_name, :address_1, :address_2, :city, :state, :postal_code]
    
    conf.update.columns = [:address_1, :address_2, :city, :state, :postal_code]
    
    conf.list.sorting = [{:last_name => :asc}, {:first_name => :asc }]
    conf.list.per_page = 25

    conf.columns[:uin].label = "UIN"
    conf.columns[:last_name].label = "Last Name"
    conf.columns[:first_name].label = "First Name"
  end
  
end
