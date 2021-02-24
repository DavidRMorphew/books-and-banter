class UsersController < ApplicationController
  # add before_action for delete for admin_authorization?
  # add redirect_if_not_logged_in to show and check current_user
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  
  def show
    redirect_if_not_logged_in
    @user = User.find_by(id: params[:id])
    @books = @user.borrowed_books.currently_checked_out_books
    @reviews = @user.reviews
    redirect_if_not_authorized_to_view(@user)
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end