class TagsController < ApplicationController
  def index
    @tag = params[:name]
    @products = Product.tagged_with(@tag)
    @organizations = Organization.tagged_with(@tag)
    @people = Person.tagged_with(@tag)
  end  
end