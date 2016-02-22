class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  

  def confirm_logged_in
    unless cookies[:auth_token]
      redirect_to(:controller => 'access', :action => 'login')
      false # halts the before_action
    else
      true
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user
end
