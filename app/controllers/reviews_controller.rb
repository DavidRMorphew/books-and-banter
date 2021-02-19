class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  def new
    # binding.pry
    @book = Book.find_by(id: params[:book_id])
    @review = @book.reviews.build
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review.id)
    else
      @book = Book.find_by(id: params[:book_id])
      render :new
    end
  end

  def index
  end

  def show
    @review = Review.find_by(id: params[:id])
    @book = @review.reviewed_book
  end

  private
    
  def review_params
      params.require(:review).permit(:title, :content, :rating, :recommend, :kid_friendly, :reviewed_book_id)
  end
end
