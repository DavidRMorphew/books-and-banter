module BooksHelper
    def book_index_title_display
        if number = params[:number]
            tag.h1("Top #{number} Highest Rated Books")
        else
            tag.h1("Our Library")
        end
    end
end
