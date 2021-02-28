class Checkout < ApplicationRecord
    belongs_to :borrower, class_name: "User"
    belongs_to :borrowed_book, class_name: "Book"
    validates :borrowed_book, :borrower, presence: true

    def self.grouped_by_checked_in_status
        self.order(:checked_in)
    end
end
