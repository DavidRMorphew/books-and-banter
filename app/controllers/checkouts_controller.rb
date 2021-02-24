class CheckoutsController < ApplicationController
  def create
    # binding.pry
    if book = Book.find_by(id: params[:book_id])
      binding.pry
      checkout = current_user.checkouts.create(borrowed_book: book)
      checkout.checkout_date = Time.now
      checkout.due_date = checkout.checkout_date + 2.week
      book.update(currently_checked_out: true)
      binding.pry
      # book.change_checkout_status
    end
    redirect_to book_path(book)
  end

  def update
    binding.pry
  end
end
