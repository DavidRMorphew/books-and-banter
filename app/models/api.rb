class Api < ApplicationRecord
    
    def self.fetch_books(query)
        url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    
        uri = URI(url)
        response = Net::HTTP.get(uri)
        google_books_hash = JSON.parse(response)
        books_array = google_books_hash["items"]
        # binding.pry

        if !books_array
            binding.pry

            # come back to how to display this:
            books_array = ["No matches found."]
        end
        binding.pry
        books_array.map do |book_hash|
            binding.pry
            book_assignment_hash = {}
            # better way to do this?
            volume_info = book_hash["volumeInfo"]
            book_assignment_hash[:authors] = volume_info["authors"].join(", ")
            book_assignment_hash[:description] = volume_info["description"]
            book_assignment_hash[:publisher] = volume_info["publisher"]

            b = Book.new(book_assignment_hash)
            binding.pry
        end
    end

end