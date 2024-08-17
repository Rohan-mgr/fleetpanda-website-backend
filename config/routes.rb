Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions"}
  # get 'organizations/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :blogs, only: [:index, :create, :show, :update, :destroy ] do
    resources :comments, only: [:index, :create, :update, :destroy]
  end
  
  resources :users do 
    member {get 'info'}
    member {post 'upload_profile'}
    
    post 'profiles', to: "profiles#create"
    put 'profiles', to: "profiles#update"
    
    resources :comments, only: [:index, :create, :update, :destroy]
  end
  resources :organizations, only: [:index, :fetch_users] do
    resources :users, only: [:index] 
  end
end
