module BooksHelper
    
    def search_keys_selection
        search_keys = ["search_author_name", "search_title", "search_description", "ordering_filter"]
        selected_keys = search_keys.select do |key|
            !params["#{key}"].blank?
        end
        search_filters_hash = {}
        selected_keys.each do |key|
            search_filters_hash[key] = params["#{key}"]
        end
        search_filters_hash
    end

    def search_filter_chaining_method(search_filters_hash)
        result = Book
        search_filters_hash.each do |key, value|
          key == "ordering_filter" ? result = result.send("#{value}") : result = result.send("#{key}", value)
        end
        result
    end
    
    def book_index_title_display
        if number = params[:number]
            tag.h1("Top #{number} Most Reviewed Books")
        else
            tag.h1("Our Library")
        end
    end

    def display_aggregate_book_rating(book)
        if book && book.aggregate_book_rating
            "#{book.aggregate_book_rating.round(2)} Average User Rating"
        end
    end

    def checkout_button_or_checked_out_status_display(book)
        if !book.currently_checked_out
            button_to "Check this book out of the library", book_checkouts_path(book.id), class: "btn indigo darken-4"
        elsif current_borrower(book) == current_user
            button_to "Return Book (#{book_due_date(book)})", book_checkout_path(book.id, current_checkout_record(book).id), method: :patch, class: "btn indigo darken-4"
        else
            tag.h4("This book is currently checked out.")
        end
    end

    def current_borrower(book)
        if book.currently_checked_out
            current_checkout_record(book).borrower
        end
    end

    def current_checkout_record(book)
        if book.currently_checked_out
            book.checkouts.order(:created_at).last
        end
    end

    def book_due_date(book)
        due_date = current_checkout_record(book).due_date
        "DUE: #{format_date(due_date)}"
    end
end
