class TwitterController < ApplicationController
  helper_method :sort_column, :sort_direction, :aspect_column


  def index
    @stats = TwitterSummary
      .sortable(sort_column, sort_direction)
      .paginate(:per_page => params[:per_page] || 50, :page => params[:page])
  end

  def top_ten
    @stats = TwitterSummary
      .sortable(aspect_column, 'desc')
      .limit(10)
      .all

    respond_to do |format|
      format.html
      format.json { render :json => @stats.collect { |stat| {:name => stat.organization.name, :handle => stat.twitter_stat.screen_name, aspect_column => stat[aspect_column]}}.to_json }
    end
  end

  private

  def aspect_column
    TwitterSummary.aspect_columns.include?(params[:aspect]) ? params[:aspect] : TwitterSummary.aspect_columns.first
  end

  def sort_column
   TwitterSummary.sortable_columns.include?(params[:sort]) ? params[:sort] : TwitterSummary.sortable_columns.first
  end

  def sort_direction
    TwitterSummary.sortable_directions.include?(params[:direction]) ? params[:direction] : TwitterSummary.sortable_directions.first
  end
end
