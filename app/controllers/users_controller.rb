class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account created!"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
