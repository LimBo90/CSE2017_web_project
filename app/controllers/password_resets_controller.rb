class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash[:notice] = "Can't find that email."
      render 'new'
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr;
      reset has expired."
    elsif !(params[:user][:password].present?)
      puts "params[:password].present? = #{params[:password].present?}"
      @user.errors.add(:password, "can't be blank")
      render :edit
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
