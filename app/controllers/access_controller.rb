class AccessController < ApplicationController

  before_action :confirm_logged_in,:current_user, :except => [:login, :attempt_login, :logout]


  def login
    # login form
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      if params[:remember_me]
        cookies.permanent[:auth_token] = authorized_user.auth_token
      else
        cookies[:auth_token] = authorized_user.auth_token
      end
      flash[:notice] = "Hello #{authorized_user.name}"
      redirect_to(documents_path)
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(:action => 'login')
    end
  end

  def logout
    #mark user as logged out
    cookies.delete(:auth_token)
    redirect_to(:action => "login")
  end

end
