class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  def new
    # binding.pry
    book = Book.find_by(id: params[:book_id])
    @review = current_user.reviews.build(reviewed_book: book)
  end

  

  def index
  end

  def show
  end
end