class Book < ApplicationRecord
    validates :authors, :title, :description, :publisher, :publication_date, :categories, presence: true
    validates :title, uniqueness: { scope: :authors, message: "with the same author is already in our libray." }
end
