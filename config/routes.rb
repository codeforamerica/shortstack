Orgbase::Application.routes.draw do
  
  

  resources :links

  resources :link_types

  resources :note_types
  resources :notes

  resources :people, :organizations, :products do
    resources :notes
    resources :links
  end 

  resources :contributions

  resources :profiles

  resources :products

  resources :organizations

  resources :org_types

  match '/auth/:provider/callback' => 'authentications#create'
  resources :settings
  resources :authentications
  devise_for :users, :controllers => {:registrations => 'registrations'}
  root :to => "home#index"

end
