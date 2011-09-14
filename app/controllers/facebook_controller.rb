class FacebookController < ApplicationController
  helper_method :sort_column, :sort_direction, :aspect_column


  def index
    @stats = FacebookSummary
      .sortable(sort_column, sort_direction)
      .paginate(:per_page => params[:per_page] || 50, :page => params[:page])
  end

  def top_ten
    @stats = FacebookSummary
      .sortable(aspect_column, 'desc')
      .limit(10)
      .all

    respond_to do |format|
      format.html
      format.json { render :json => @stats.collect { |stat| {:name => stat.organization.name, :handle => stat.facebook_stat.screen_name, aspect_column => stat[aspect_column]}}.to_json }
    end
  end

  private

  def aspect_column
    FacebookSummary.aspect_columns.include?(params[:aspect]) ? params[:aspect] : FacebookSummary.aspect_columns.first
  end

  def sort_column
   FacebookSummary.sortable_columns.include?(params[:sort]) ? params[:sort] : FacebookSummary.sortable_columns.first
  end

  def sort_direction
    FacebookSummary.sortable_directions.include?(params[:direction]) ? params[:direction] : FacebookSummary.sortable_directions.first
  end
end
