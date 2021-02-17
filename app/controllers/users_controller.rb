class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  
  def show
    # Only allow access if current user is the one attempting to access page
    @user = User.find_by(id: params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end