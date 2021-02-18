class BooksController < ApplicationController
  # Add before_action to find book in create, show, edit, delete
  # Add before_action to check for admin for new, edit, delete
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_admin_authorized, only: [:new, :create, :edit, :update, :destroy]

  def new
    # only for admin and link visible in admin layout
      @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :new
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
    @book = Book.find_by(id: params[:id])
    # link from books#show for admin only
  end

  def update
    # only for admin
  end

  def delete
    # admin only, only when book is not currently checked out
  end

  # add class method of highest_rated

  # add query method for searching through library - author, rating, categories, title (name_like)

  private

  def book_params
    params.require(:book).permit(:authors, :isbn, :title, :description, :publisher, :publication_date, :categories)
  end

end
