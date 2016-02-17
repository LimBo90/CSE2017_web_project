class UsersController < ApplicationController

  before_action :confirm_logged_in, :except => [:create, :new]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # Instantiate a new object using form parameters
    @user = User.new(user_params)
    # Save the object
    if @user.save
      # If save succeeds, redirect to the index action
      flash[:notice] = "user created successfully."
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect_to(root_path)
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # Find an existing object using form parameters
    @user = User.find(params[:id])
    # Update the object
    if @user.update_attributes(user_params)
      # If update succeeds, redirect to the index action
      flash[:notice] = "user updated successfully."
      redirect_to(user_path(@user.id))
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def change_password
    @user = User.find(params[:id])
    #change_password form
  end

  def attempt_update_password
  	 @user = User.find(params[:id])
    if params[:user][:current_password].present? && params[:user][:password].present? && params[:user][:password_confirmation].present?
      if @user
        authorized_user = @user.authenticate(params[:user][:current_password])
        end
      if authorized_user
      	puts "inside attempt_update_password" + user_params.inspect
        if @user.update_attributes(user_params)
          flash[:notice] = "Password has been changed."
          redirect_to(root_path)
        else
          render('change_password')
        end
      else
        flash[:notice] = "Incorrect current password."
        redirect_to(:action => 'change_password',:id => params[:id])
      end
    else
      flash[:notice] = "Fields can not be blank."
      redirect_to(:action => 'change_password',:id => params[:id])
    end
  end

  def delete
    @user = User.find(params[:id])
    #if the user deleted himself all the slides the user uploaded need to be deleted as well
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:notice] = "user '#{user.name}' destroyed successfully."
    session[:user_id] = nil
    session[:username] = nil
    redirect_to(:controller => 'access', :action => 'login')
  end


  private

  def user_params
    # same as using "params[:user]", except that it:
    # - raises an error if :user is not present
    # - allows listed attributes to be mass-assigned
    params.require(:user).permit(:username, :first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation, :birth_date)
  end

end
