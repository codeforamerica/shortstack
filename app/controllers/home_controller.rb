class HomeController < ApplicationController
  before_filter :authenticate_user!  
  def index
    @contributions = Contribution.order('updated_at DESC').limit(10)
    @people = Person.order('created_at DESC').limit(10)
    @products = Product.order('created_at DESC').limit(10)    
    @organizations = Organization.order('created_at DESC').limit(10)        
  end
  
end
