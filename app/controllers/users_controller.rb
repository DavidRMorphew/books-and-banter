class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    binding.pry
    if user.save
      redirect_to user_path(user.id)
    else
      render :new
    end
  end
  
  def show
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
