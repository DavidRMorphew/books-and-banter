class ReviewsController < ApplicationController
  include ReviewsHelper

  before_action :redirect_if_not_logged_in
  
  def new
    # binding.pry
    @book = Book.find_by(id: params[:book_id])
    if user_reviewed_book_already?(@book)
      flash[:message] = "You have already reviewed this book."
      redirect_to book_path(@book.id)
    end
    
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
    if params[:book_id] && @book = Book.find_by(id: params[:book_id])
      @reviews = @book.reviews
    elsif admin?
      @reviews = Review.all
    else
      flash[:message] = "That book was not found. Please select a book."
      redirect_to books_path
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
    @book = @review.reviewed_book
  end

  def edit
    @review = Review.find_by(id: params[:id])

    if !authorized_to_edit_review?(@review)
      flash[:message] = "You are not authorized to edit that review."
      redirect_to user_path(current_user)
    end
    @book = @review.reviewed_book
  end

  def update
    @review = Review.find_by(id: params[:id])

    if @review.update(review_params)
      redirect_to review_path(@review.id)
    else
      @book = @review.reviewed_book
      render :edit
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    if authorized_to_destroy_review?(@review)
      @review.destroy
      redirect_to books_path
    else
      flash[:message] = "You are not authorized to remove that review."
      redirect_to user_path(current_user)
    end
  end

  private
    
  def review_params
      params.require(:review).permit(:title, :content, :rating, :recommend, :kid_friendly, :reviewed_book_id)
  end
end
