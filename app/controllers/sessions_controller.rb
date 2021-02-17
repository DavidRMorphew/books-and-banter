class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:message] = "Email and/or password invalid. Please try again."
      render :new
    end
  end
end
