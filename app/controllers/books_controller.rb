class BooksController < ApplicationController
  # Add before_action to find book in show, edit, delete called set_book
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_admin, only: [:new, :create, :edit, :update, :destroy]
  include BooksHelper

  def new
    if params[:search]
      query_for_api = Book.format_query(params[:search])
      if fetched_books = Api.fetch_books(query_for_api)
        @google_books_instance = fetched_books.first
      else
        flash[:message] = "No search results. Please try again."
        @book = Book.new
      end
    else
      @book = Book.new
    end
  end

  def create
    if params[:google_books_instance_isbn]
      search_query = "isbn:" + params[:google_books_instance_isbn].split(",").first
      @book = Api.fetch_books(search_query).first
    else
      @book = Book.new(book_params)
    end

    if @book.save
      redirect_to book_path(@book.id)
    else
      render :new
    end
  end

  def index
    if !search_keys_selection.empty?
      search_results = search_filter_chaining_method(search_keys_selection)
      if !search_results.empty?
        @books = search_results
      else
        flash[:message] = "No results found for those criteria."
        @books = Book.all
      end
    else
      @books = Book.all
    end
  end

  def show
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

  # add class method of highest_rated with action here and route: books/highest_rated - need method in Book to define it with scope

  # add query method for searching through library - author, rating, categories, title (name_like)

  private

  def book_params
    params.require(:book).permit(:authors, :isbn, :title, :description, :publisher, :publication_date, :categories)
  end
end
