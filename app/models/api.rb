class Api < ApplicationRecord
    
    def self.fetch_books(query)
        url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    
        uri = URI(url)
        response = Net::HTTP.get(uri)
        google_books_hash = JSON.parse(response)
        books_array = google_books_hash["items"]
        binding.pry

        if !books_array
            # come back to how to display this:
            "No matches found."
        end

        books_array.map do |book_hash|
            book_assignment_hash = {}
            # better way to do this?
            volume_info = book_hash["volumeInfo"]
            book_assignment_hash[:authors] = volume_info["authors"].join(", ") if volume_info["authors"]

            Book.new(book_assignment_hash)
            binding.pry
        end
    end

end