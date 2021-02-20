class BooksController < ApplicationController
  # Add before_action to find book in create, show, edit, delete
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    # only for admin and link visible in admin layout
      @book = Book.new
      # order by created_at by default
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
    # binding.pry
    if params[:most_recently_added]
      @books = Book.most_recently_added
    elsif params[:has_reviews]
      @books = Book.has_reviews
    elsif params[:highest_rated]
      @books = Book.ordered_by_aggregate_ratings
    else
      @books = Book.all
    end
  end

  def show
    # access only if not_checked_out || current_users borrowed book
    @book = Book.find_by(id: params[:id])
  end

  def edit
    # only for admin
    @book = Book.find_by(id: params[:id])
    # link from books#show for admin only
  end

  def update
    # only for admin
    @book = Book.find_by(id: params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    # admin only, only when book is not currently checked out
    @book = Book.find_by(id: params[:id])
    # !@book.currently_checked_out?
    @book.destroy
    redirect_to books_path
  end

  def most_reviewed
    @books = Book.most_reviewed.limit(params[:number])
    render :index
  end

  # add class method of highest_rated with action here and route: books/highest_rated - need method in Book to define it with scope

  # add query method for searching through library - author, rating, categories, title (name_like)

  private

  def book_params
    params.require(:book).permit(:authors, :isbn, :title, :description, :publisher, :publication_date, :categories)
  end

end
