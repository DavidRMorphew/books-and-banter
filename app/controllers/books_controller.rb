class BooksController < ApplicationController
  # Add before_action to find book in create, show, edit, delete
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    # only for admin and link visible in admin layout
    binding.pry
    if params[:search]
      binding.pry
    end
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
    search_keys = ["search_author_name", "search_title", "most_recently_added", "most_recently_published", "ordered_by_aggregate_ratings"]
    filter_keys = search_keys.select do |key|
      params["#{key}"]
    end
    search_hash = {}
    filter_keys.each do |key|
      search_hash[key] = params["#{key}"]
    end
    # binding.pry
    if !filter_keys.empty?
      result = Book
      search_hash.each do |method_name, value|
        value == "1" ? result = result.send("#{method_name}") : result = result.send("#{method_name}", value)
      end
      if !result.empty?
        @books = result
      else
        flash[:message] = "No results found for those criteria."
        @books = Book.all
      end
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
