module CheckoutsHelper
    def borrowed_book_title(checkout)
        checkout.borrowed_book.title
    end

    def borrower_username(checkout)
        checkout.borrower.username
    end

    # display checked out status
end
