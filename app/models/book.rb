class Book < ApplicationRecord
    validates :authors, :title, :description, :publisher, :publication_date, :categories, presence: true
    validates :title, uniqueness: { scope: :authors, message: "with the same author is already in our libray." }

    def display_description
        !self.description.match(/[.]\z/) ? self.description << "." : self.description
    end

    def display_authors
        authors_array = self.authors.split(",")
        case authors_array.count
        when 1
            self.authors
        when 2
            authors_array.join(" and ")
        when 3..100
            authors_array[-1] = "and " + authors_array[-1]
            authors_array.join(", ")
        end
    end
end
