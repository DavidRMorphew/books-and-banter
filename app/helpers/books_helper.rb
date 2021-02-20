module BooksHelper
    def book_index_title_display
        if number = params[:number]
            tag.h1("Top #{number} Highest Rated Books")
        else
            tag.h1("Our Library")
        end
    end

    def display_aggregate_book_rating(book)
        if book && book.aggregate_book_rating
            "#{book.aggregate_book_rating.round(2)} Average User Rating"
        end
    end
end
