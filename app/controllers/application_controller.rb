class PermissionError < Exception; end
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user

  def set_user
    if current_user
    $current_user = current_user #make current_user accessible to models for post_hooks
    end
  end

  def authorize_user
    raise PermissionError unless $current_user.admin?
  end

  rescue_from PermissionError do
    render_404
  end

  def render_404
    #respond_to do |format|
    #  format.html { render "#{RAILS_ROOT}/public/404.html", :status => :not_found }
    #end
    redirect_to root_url
  end
end
