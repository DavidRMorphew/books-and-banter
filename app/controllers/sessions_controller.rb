class SessionsController < ApplicationController
  def new
  end
  def create
    binding.pry
    user = User.find_by(email: params[:email].downcase)
  end
end
