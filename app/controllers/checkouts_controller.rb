class CheckoutsController < ApplicationController
  include BooksHelper
  
  def create
    # binding.pry
    book = Book.find_by(id: params[:book_id])
    if book && !book.currently_checked_out
      # binding.pry
      checkout = current_user.checkouts.create({
        borrowed_book: book,
        checkout_date: Time.now,
        due_date: Time.now + 2.week,
      })
      book.update(currently_checked_out: true)
      # binding.pry
      # book.change_checkout_status
    else
      flash[:message] = "You cannot check out this book"
    end
    redirect_to book_path(book)
  end

  def index
    if admin?
      @checkouts = Checkout.all(created_at: :desc)
    else
      @checkouts = current_user.checkouts.order(created_at: :desc)
    end
  end

  def update
    # binding.pry
    book = Book.find_by(id: params[:book_id])
    checkout = Checkout.find_by(id: params[:id])
    if current_borrower(book) == current_user
      checkout.update(due_date: nil)
      book.update(currently_checked_out: false)
      redirect_to book_path(book)
    else
      flash[:message] = "You cannot check in that book"
    end
  end
end
