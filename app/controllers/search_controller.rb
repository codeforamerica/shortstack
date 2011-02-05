class SearchController < ApplicationController
  

  def index
    @results = Sunspot.search(Organization, Product, Person) do
      keywords params[:search]
    end

  end
end
