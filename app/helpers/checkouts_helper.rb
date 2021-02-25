module CheckoutsHelper
    def borrowed_book_title(checkout)
        checkout.borrowed_book.title
    end
end
