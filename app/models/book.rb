class Book < ApplicationRecord
    has_many :checkouts, foreign_key: :borrowed_book_id
    has_many :borrowers, through: :checkouts, source: :borrower
    has_many :reviews, foreign_key: :reviewed_book_id
    has_many :reviewers, through: :reviews, source: :reviewer
    validates :authors, :title, :description, :publisher, :publication_date, :categories, :isbn, presence: true
    validates :title, uniqueness: { scope: :authors, message: "with the same author is already in our libray" }
    validate :publication_date_year_valid, if: :publication_date

    def self.format_query(queries)
        submitted_queries = queries.reject { |k,v| v.empty? }

        submitted_queries[:title] = "intitle:#{submitted_queries[:title]}" if submitted_queries[:title]
        submitted_queries[:author] = "inauthor:#{submitted_queries[:author]}" if submitted_queries[:author]
        submitted_queries[:category] = "subject:#{submitted_queries[:category]}" if submitted_queries[:category]
        submitted_queries[:isbn] = "isbn:#{submitted_queries[:isbn]}" if submitted_queries[:isbn]

        formatted_search_query = submitted_queries.values.join("+")
    end
# Am I using this method or did I forget about it?
    def self.books_instances_array_from_api(query)
        if Api.fetch_books(query).nil?
            "No matches found. Please try again."
        else 
            new_books_array = Api.fetch_books(query)
        end
    end

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
        self.has_reviews.sort_by { |book| book.aggregate_book_rating }.reverse
    end

    def self.most_recently_added
        self.order(created_at: :desc)
    end

    def self.most_recently_published
        self.order(publication_date: :desc)
    end

    def self.search_author_name(author_query)
        Book.where("authors LIKE ?", "%#{author_query}%")
    end

    def self.search_title(title_query)
        Book.where("title LIKE ?", "%#{title_query}%")
    end
end
