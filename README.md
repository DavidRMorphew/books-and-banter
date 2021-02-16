# PROJECT PLANNING

1) MODELS AND MIGRATIONS   

User
has_many :checkouts, foreign_key: :borrower_id
has_many :borrowed_books, through: :checkouts, source: :borrowed_book
has_many :reviews, foreign_key: :reviewer_id
has_many :reviewed_books, through: :reviews, source: :reviewed_book

Checkout
belongs_to :borrower, class_name: "User"
belongs_to :borrowed_book, class_name: "Book"

Review
belongs_to :reviewer, class_name: "User"
belongs_to :reviewed_book, class_name: "Book"

Book
has_many :checkouts, foreign_key: :borrowed_book_id
has_many :borrowers, through: :checkouts, source: :borrower
has_many :reviews, foreign_key: :reviewed_book_id
has_many :reviewers, through: :reviews, source: :reviewer