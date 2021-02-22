class Api < ApplicationRecord
    
    def self.fetch_books(query)
        url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    
        uri = URI(url)
        response = Net::HTTP.get(uri)
        google_books_hash = JSON.parse(response)
        books_array = google_books_hash["items"]
        binding.pry
    end

end