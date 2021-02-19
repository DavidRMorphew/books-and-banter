module ReviewsHelper
    def display_boolean_yes_no(boolean)
        true ? "Yes" : "No"
    end

    def review_title
        if params[:book_id]
            tag.h1("'#{@book.title},' reviewed by #{current_user.username}")
        else
            tag.h1("'#{@book.title},' reviewed by #{@review.reviewer.username}")
        end
    end

    def reviews_title
        if params[:book_id]
            tag.h1("All Reviews of '#{@book.title}'")
        else
            tag.h1("All Reviews")
        end
    end

    def recommend_display(review)
        if review.recommend
            "Recommended? " + display_boolean_yes_no(review.recommend)
        end
    end
    
    def kid_friendly_display(review)
        if review.kid_friendly
            "Kid Friendly? " + display_boolean_yes_no(review.kid_friendly)
        end
    end

    def authorized_to_edit_review?(review)
        review.reviewer == current_user
    end
    
    def authorized_to_destroy_review?(review)
        admin? || review.reviewer == current_user
    end

    def user_reviewed_book_already?(book)
        current_user.reviewed_books.where(reviewed_book: book)
    end
end
