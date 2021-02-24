class CheckoutsController < ApplicationController
  include BooksHelper
  # ask about using this

  def create
    # binding.pry
    if book = Book.find_by(id: params[:book_id])
      # binding.pry
      checkout = current_user.checkouts.create({
        borrowed_book: book,
        checkout_date: Time.now,
        due_date: Time.now + 2.week,
      })
      book.update(currently_checked_out: true)
      binding.pry
      # book.change_checkout_status
    end
    redirect_to book_path(book)
  end

  def update
    binding.pry
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
