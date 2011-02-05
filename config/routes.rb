Orgbase::Application.routes.draw do
  
  get "search/index"

  #details
  resources :contacts
  resources :relationships
  resources :addresses  
  resources :links
  resources :notes
  resources :whisks  
  resources :managetags, :collection => {:tags => :any, :categories => :any, :rename => :any, :remove => :any, :remove_tagging => :any}
  match "/tags/:id/:name" => "tags#index"
  match 'products/whiskme/:id', :to => 'products#whiskme'  
  
  #objects
  resources :people, :organizations, :products do
    resources :notes
    resources :links
    resources :relationships
    resources :addresses
    resources :contacts
    resources :whisks
  end 

  #types
  resources :org_types
  resources :link_types
  resources :note_types
  resources :relation_types  
  resources :whisk_types

  #users
  resources :contributions  
  resources :profiles
  match '/auth/:provider/callback' => 'authentications#create'
  resources :settings
  resources :authentications
  devise_for :users, :controllers => {:registrations => 'registrations'}

  #search
  match 'search', :to => 'search#index'

  #home
  root :to => "home#index"
  
  #profilename
  

end
