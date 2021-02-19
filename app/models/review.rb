class Review < ApplicationRecord
    belongs_to :reviewer, class_name: "User"
    belongs_to :reviewed_book, class_name: "Book"
end
