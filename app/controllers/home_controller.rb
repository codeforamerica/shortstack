class HomeController < ApplicationController
  before_filter :authenticate_user!
  caches_page :index
    
  def index
    @contributions = Contribution.order('updated_at DESC').limit(10).includes(:user =>  :profile)
    @people = Person.recent.limit(10)
    @products = Product.recent.limit(10)    
    @organizations = Organization.recent.limit(10)        
  end
  
end
