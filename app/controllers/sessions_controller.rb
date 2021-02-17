class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  def create
    binding.pry
    user = User.find_by(email: params[:email])
  end
end
