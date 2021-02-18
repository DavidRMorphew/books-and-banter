class BooksController < ApplicationController
  # Add before_action to find show
  
  def new
  end

  def index
    # check for login
    @books = Book.all
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def edit
  end
end
