module CheckoutsHelper
    def borrowed_book_title(checkout)
        checkout.borrowed_book.title
    end

    def borrower_username(checkout)
        checkout.borrower.username
    end

    # make book due red font in checkout index
    def display_checked_out_status(checkout)
        if checkout.checked_in
            "BOOK RETURNED"
        else
            "BOOK DUE #{format_date(checkout.due_date)}"
        end
    end
end
