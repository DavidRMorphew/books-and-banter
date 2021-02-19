class Review < ApplicationRecord
    belongs_to :reviewer, class_name: "User"
    belongs_to :reviewed_book, class_name: "Book"
    validates :title, :content, :rating, presence: true
    validate :appropriate_language

    def appropriate_language
        inappropriate_language = [
            "fudge nuggets",
            "gee willickers",
            "dagnabbit",
            "fiddlesticks",
            "shucks",
            "dadgum",
            "mother trucker",
            "shut the front door",
            "son of a motherless goat",
            "for peet's sake"
        ]
        submitted_text = self.title.downcase + " " + self.content.downcase
        if inappropriate_language.any? { |phrase| submitted_text.scan(/(phrase)/) }
            self.errors.add(:appropriate_language, "is required for reviews")
        end
    end
    private
    def review_params
        params.require(:review).permit(:title, :content, :rating, :recommend, :kid_friendly)
    end
end
