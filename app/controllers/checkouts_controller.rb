class CheckoutsController < ApplicationController
  include BooksHelper
  before_action :redirect_if_not_logged_in
  
  def create
    book = Book.find_by(id: params[:book_id])
    if book && !book.currently_checked_out
      checkout = current_user.checkouts.create({
        borrowed_book: book,
        checkout_date: Time.now,
        due_date: Time.now + 2.week
      })
      book.update(currently_checked_out: true)
    else
      flash[:message] = "You cannot check out this book"
    end
    redirect_to book_path(book)
  end

  def index
    if admin?
      @checkouts = Checkout.grouped_by_checked_in_status
    else
      @checkouts = current_user.checkouts.grouped_by_checked_in_status
    end
  end

  def update
    book = Book.find_by(id: params[:book_id])
    checkout = Checkout.find_by(id: params[:id])
    if current_borrower(book) == current_user
      checkout.update(checked_in: true)
      book.update(currently_checked_out: false)
      redirect_to book_path(book)
    else
      flash[:message] = "You cannot check in that book"
    end
  end
end
