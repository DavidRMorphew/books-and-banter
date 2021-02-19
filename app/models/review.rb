class Review < ApplicationRecord
    belongs_to :reviewer, class_name: "User"
    belongs_to :reviewed_book, class_name: "Book"
    validates :title, :content, :rating, presence: true

    private
    def review_params
        params.require(:review).permit(:title, :content, :rating, :recommend, :kid_friendly)
    end
end
