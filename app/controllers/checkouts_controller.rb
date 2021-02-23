class CheckoutsController < ApplicationController
  def create
    binding.pry
    Book.find_by(id: params[:id])
    # redirect_to book_path()
  end

  def destroy
  end
end
