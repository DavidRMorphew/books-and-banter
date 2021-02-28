module CheckoutsHelper
    def borrowed_book_title(checkout)
        checkout.borrowed_book.title
    end

    def borrower_username(checkout)
        checkout.borrower.username
    end

    def display_checked_out_status(checkout)
        if checkout.checked_in
            "BOOK RETURNED"
        else
            tag.span("BOOK DUE #{format_date(checkout.due_date)}", class: "red-text text-darken-3")
        end
    end
end
