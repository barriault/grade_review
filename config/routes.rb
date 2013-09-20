GradeReview::Application.routes.draw do
  
  resources :reports do
    collection do
      get :alpha_roster
      get :probation_merge_data
      get :suspension_merge_data
      get :departmental_suspension_merge_data
      get :tamu_suspension_to_probation
      get :tamu_suspensions
      get :departmental_suspensions
    end
  end
  
  resources :students do 
    
    collection do
      put :send_emails
      post :import
      get :remove_all
    end
    
    member do
      put 'approve'
      put 'change'
      put 'remove'
    end
    
    as_routes 
  end
  
  resources :users do
    as_routes
  end
  
  resources :roles do 
    as_routes 
  end
  
  resources :terms do
    as_routes
  end

  root :to => "home#index"
  # resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider', to: lambda{|env| [404, {}, ["Not Found"]]}, as: 'auth'
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
