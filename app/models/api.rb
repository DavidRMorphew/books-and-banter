class Api < ApplicationRecord
    
    def self.fetch_books(query)
        url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&langRestrict=en&printType=books&maxResults=40&key=#{ENV["GOOGLE_BOOKS_API_KEY"]}"
    
        uri = URI(url)
        response = Net::HTTP.get(uri)
        google_books_hash = JSON.parse(response)
        books_array = google_books_hash["items"]

        return nil if !books_array
        
        books_array.map do |book_hash|

            book_assignment_hash = {}
            volume_info = book_hash["volumeInfo"]
            
            book_assignment_hash[:authors] = volume_info["authors"].join(", ") if volume_info["authors"]
            book_assignment_hash[:description] = volume_info["description"] if volume_info["description"]
            book_assignment_hash[:publisher] = volume_info["publisher"] if volume_info["publisher"]
            book_assignment_hash[:publication_date] = volume_info["publishedDate"].split("-").first.to_s if volume_info["publishedDate"]
            book_assignment_hash[:categories] = volume_info["categories"].join(", ") if volume_info["categories"]
            
            if volume_info["subtitle"]
                book_assignment_hash[:title] = volume_info["title"] + ": " + volume_info["subtitle"]
            else
                book_assignment_hash[:title] = volume_info["title"]
            end
            
            book_assignment_hash[:isbn] = volume_info["industryIdentifiers"].map do |isbn_hash|
                isbn_hash["identifier"] unless isbn_hash["identifier"].match(/\D[^\d][^X]/)
            end.join(", ") if volume_info["industryIdentifiers"]
            
            if Book.new(book_assignment_hash).valid?
                Book.new(book_assignment_hash)
            end
        end.compact
    end

end