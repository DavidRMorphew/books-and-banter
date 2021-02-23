class BooksController < ApplicationController
  # Add before_action to find book in show, edit, delete called set_book
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    if params[:search]
      query_for_api = Book.format_query(params[:search])
      if Api.fetch_books(query_for_api)
        @google_books_instance = Api.fetch_books(query_for_api).first
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
    # helper called search_keys_selection
    # search_keys = ["search_author_name", "search_title", "most_recently_added", "most_recently_published", "ordered_by_aggregate_ratings"]
    # selected_keys = search_keys.select do |key|
    #   params["#{key}"]
    # end
    # search_hash = {}
    # selected_keys.each do |key|
    #   search_hash[key] = params["#{key}"]
    # end
    # here
    # binding.pry
    if !search_keys_selection.empty?
      search_results = search_filter_chaining_method(search_keys_selection)
      if !search_results.empty?

   
    # if !selected_keys.empty?
    #   result = Book
    #   search_hash.each do |method_name, value|
    #     value == "1" ? result = result.send("#{method_name}") : result = result.send("#{method_name}", value)
    #   end
    #   if !result.empty?
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

  def search_keys_selection
    search_keys = ["search_author_name", "search_title", "ordering_filter"]
    selected_keys = search_keys.select do |key|
        !params["#{key}"].blank?
    end
    search_filters_hash = {}
    selected_keys.each do |key|
        search_filters_hash[key] = params["#{key}"]
    end
    search_filters_hash
end

def search_filter_chaining_method(search_filters_hash)
    result = Book
    search_filters_hash.each do |key, value|
      key == "ordering_filter" ? result = result.send("#{value}") : result = result.send("#{key}", value)
    end
    result
end

end
