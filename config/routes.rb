GradeReview::Application.routes.draw do
  
  resources :reports do
    member do
      get :scholastic_deficiency_by_major  
    end
    
    collection do
      get :alpha_roster
      
      get :probation_merge_data
      get :suspension_merge_data
      get :departmental_suspension_merge_data
      
      get :sail_good_standing_merge_data
      get :sail_probation_merge_data
      get :sail_suspension_merge_data
      
      get :tamu_suspension_to_probation
      get :tamu_suspensions
      get :departmental_suspensions
      get :appeals
      
      get :scholastic_deficiency_by_term
      
      get :users
    end
  end
  
  resources :students do 
    
    member do
      put 'approve'
    end
    
    as_routes 
  end
  
  resources :appeal_recommendations do 
    member do
      put 'grant'
      put 'deny'
      put 'undo'
    end
    
    as_routes 
  end
  
  resources :appeals do 
    member do
      put 'grant'
      put 'deny'
      put 'undo'
    end
    
    as_routes 
  end
  
  resources :admin_students do
    
    collection do
      put :send_emails
      post :import
      get :remove_all
    end
    
    as_routes
  end
  
  resources :addresses do 
    as_routes 
  end
  
  resources :users do
    as_routes
  end
  
  resources :roles do 
    as_routes 
  end
  
  resources :terms do
    member do
      put 'make_active'
    end

    as_routes
  end

  root :to => "home#index"
  # resources :users, :only => [:index, :show, :edit, :update ]
  match '/auth/:provider', to: lambda{|env| [404, {}, ["Not Found"]]}, as: 'auth'
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  
  mount MailPreview => 'mail_view'
  match '/mail_view/probation' => 'mail_view#probation', :as => :probation_letter
  match '/mail_view/departmental_suspension' => 'mail_view#departmental_suspension', :as => :departmental_suspension_letter
  match '/mail_view/suspension' => 'mail_view#suspension', :as => :suspension_letter
  match '/mail_view/sail_good_standing' => 'mail_view#sail_good_standing', :as => :sail_good_standing_letter
  match '/mail_view/sail_probation' => 'mail_view#sail_probation', :as => :sail_probation_letter
  match '/mail_view/sail_suspension' => 'mail_view#sail_suspension', :as => :sail_suspension_letter
  
end
