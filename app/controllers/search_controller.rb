class SearchController < ApplicationController
  

  def index
    if params[:search].empty?
      @results = nil
    else
      @results = Sunspot.search(Organization, Product, Person) do
        keywords params[:search]
      end
    end
  end
end
