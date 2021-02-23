class Checkout < ApplicationRecord
    belongs_to :borrower, class_name: "User"
    belongs_to :borrowed_book, class_name: "Book"
    validates :borrowed_book, :borrower, presence: true
end
