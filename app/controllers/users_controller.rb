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
      session[:name]= @user.name
      redirect_to(:controller => :access ,:action => 'index')
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

  def delete
    #TODO: if the user deleted himself all the slides the user uploaded need to be modified
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:notice] = "user '#{user.name}' destroyed successfully."
    session[:user_id] = nil
    session[:username] = nil
    session[:name]= nil
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
