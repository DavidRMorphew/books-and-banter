class BooksController < ApplicationController
  # Add before_action to find book in create, show, edit, delete
  # Add before_action to check for admin for new, edit, delete
  before_action :redirect_if_not_logged_in

  def new
    # only for admin and link visible in admin layout
    if admin_authorization?
      @book = Book.new
    else
      redirect_to books_path
    end
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

  # add class method of highest_rated

  # add query method for searching through library - author, rating, categories, title (name_like)
end
