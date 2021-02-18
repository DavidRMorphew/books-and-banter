class Checkout < ApplicationRecord
    belongs_to :borrower, class_name: "User"
    belongs_to :borrowed_book, class_name: "Book"
end
