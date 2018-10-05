class SessionsController < ApplicationController
  def new
    user = User.new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully logged in!"
      redirect_to root_path
    else
      flash[:alert] = "Incorrect email or password, try again."
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = "Successfully logged out!"
    redirect_to login_path
  end

end
