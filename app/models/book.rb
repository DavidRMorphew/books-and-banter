class Book < ApplicationRecord
    has_many :checkouts, foreign_key: :borrowed_book_id
    has_many :borrowers, through: :checkouts, source: :borrower
    has_many :reviews, foreign_key: :reviewed_book_id
    has_many :reviewers, through: :reviews, source: :reviewer
    validates :authors, :title, :description, :publisher, :publication_date, :categories, :isbn, presence: true
    validates :title, uniqueness: { scope: :authors, message: "with the same author is already in our libray" }
    validate :publication_date_year_valid

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

    def publication_date_year_valid
        if !self.publication_date.to_i || self.publication_date.length != 4
            self.errors.add(:publication_date, "must be formatted as a four-digit number")
        elsif self.publication_date.to_i > Time.now.year
            self.errors.add(:publication_date, "cannot be in the future")
        end
    end

    # Check on this or remove
    def self.most_reviewed
        # self.order(rating: :desc)
        self.joins(:reviews).group(:reviewed_book_id).order(reviews: :desc)
        # binding.pry
    end

    def aggregate_book_rating
        self.reviews.average(:rating)
    end

    def self.has_reviews
        self.all.select {|book| !book.reviews.empty? }
    end

    def self.ordered_by_aggregate_ratings
        self.has_reviews.sort_by { |book| book.aggregate_book_rating }
    end
end
