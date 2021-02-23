class SessionsController < ApplicationController
  def new
    # perhaps redirect_if_logged_in before_action
    if logged_in?
      redirect_to user_path(current_user)
    end
  end

  def omniauth
    # binding.pry
    user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex(16)
    end
    binding.pry
    if user.valid?
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
      render :new
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
