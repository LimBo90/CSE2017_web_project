class AccessController < ApplicationController
  def login

  end

  def sign_up

  end

  def index

  end

  def attempt_login
  	if params[:username].present? && params[:password].present?
  		found_user = User.where(:username => params[:username])
  		if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
      if authorized_user
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are now logged in."
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Invalid username/password"
      redirect_to(:action => 'login')
    end
  	
  end
end

end
