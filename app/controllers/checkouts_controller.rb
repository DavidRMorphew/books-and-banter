class CheckoutsController < ApplicationController
  def create
    # binding.pry
    if book = Book.find_by(id: params[:book_id])
      binding.pry
      # checkout = book.checkouts.new
      # book.change_checkout_status
    end
    redirect_to book_path(book)
  end

  def update
  end
end
