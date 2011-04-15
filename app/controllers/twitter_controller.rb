class TwitterController < ApplicationController
  helper_method :sort_column, :sort_direction
  

  def index
    @stats = TwitterSummary
      .sortable(sort_column, sort_direction)
      .paginate(:per_page => 50, :page => params[:page])
  end

  private

  def sort_column
   TwitterSummary.sortable_columns.include?(params[:sort]) ? params[:sort] : TwitterSummary.sortable_columns.first
  end

  def sort_direction
    TwitterSummary.sortable_directions.include?(params[:direction]) ? params[:direction] : TwitterSummary.sortable_directions.first
  end
end
