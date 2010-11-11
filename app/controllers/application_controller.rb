class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_user
  before_filter :authenticate_user!  
  
  def set_user
    if current_user
    $current_user = current_user #make current_user accessible to models for post_hooks
    end
  end
end
