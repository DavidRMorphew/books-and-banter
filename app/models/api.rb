class Api < ApplicationRecord
    
    def self.fetch_books(query)
        url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&key=#{ENV["GBOOKS_API_KEY"]}"
    end

end