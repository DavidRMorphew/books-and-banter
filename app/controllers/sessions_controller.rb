class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def omniauth
    user = User.create_from_omniauth(auth)

    if user.valid?
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:message] = "#{user.errors.full_messages.join("")}."
      redirect_to login_path
    end
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:message] = "Email and/or password invalid. Please try again."
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
