class SessionsController < ApplicationController
  def new
    # check for logged_in? and redirect if logged in - perhaps redirect_if_logged_in before_action
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:message] = "Email and/or password invalid. Please try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end
end
