class BooksController < ApplicationController
  # Add before_action to find show
  
  def new
    # only for admin
  end

  def index
    # check for login
    @books = Book.all
  end

  def show
    # access only if not_checked_out and logged_in?
    @book = Book.find_by(id: params[:id])
  end

  def edit
    # only for admin
  end
end
