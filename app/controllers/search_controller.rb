class SearchController < ApplicationController
  def index
    if params[:search].nil? || params[:search].empty?
      @results = nil
    else
      @results = Sunspot.search(Organization, Product) do
        keywords params[:search] do
          highlight :notes
        end
        paginate :per_page => (params[:limit] || 30)
      end
    end
  end
end
