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
end
