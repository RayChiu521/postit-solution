class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_user

  helper_method :current_user, :logged_in?, :is_admin?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def is_admin?
    current_user and current_user.admin?
  end

  def require_admin
    access_denied("You can't do that.") unless logged_in? and current_user.admin?
  end

  def access_denied(msg = "You can't do that.")
    flash[:error] = msg
    redirect_to root_path
  end

  private

  def require_user
    access_denied("Please log in.") unless logged_in?
  end
end
