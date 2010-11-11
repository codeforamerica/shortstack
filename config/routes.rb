Orgbase::Application.routes.draw do
  
  #details
  resources :contacts
  resources :relationships
  resources :addresses  
  resources :links
  resources :notes

  #objects
  resources :people, :organizations, :products do
    resources :notes
    resources :links
    resources :relationships
    resources :addresses
    resources :contacts
  end 

  #types
  resources :org_types
  resources :link_types
  resources :note_types
  resources :relation_types  

  #users
  resources :contributions  
  resources :profiles
  match '/auth/:provider/callback' => 'authentications#create'
  resources :settings
  resources :authentications
  devise_for :users, :controllers => {:registrations => 'registrations'}

  #home
  root :to => "home#index"

end
