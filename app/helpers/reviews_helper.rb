module ReviewsHelper
    def display_boolean_yes_no(boolean)
        boolean ? "Yes" : "No"
    end

    def review_page_title
        if params[:book_id]
            tag.h3("'#{@book.title},' reviewed by #{current_user.username}")
        else
            tag.h3("'#{@book.title},' reviewed by #{@review.reviewer.username}")
        end
    end

    def reviews_page_title
        if params[:book_id]
            tag.h1("All Reviews of '#{@book.title}'")
        else
            tag.h1("All Reviews")
        end
    end

    def rating_display(review)
        "Rating: #{review.rating} / 10"
    end

    def recommend_display(review)
        "Recommended? " + display_boolean_yes_no(review.recommend)
    end
    
    def kid_friendly_display(review)
        "Kid Friendly? " + display_boolean_yes_no(review.kid_friendly)
    end

    def reviewer_username(review)
        review.reviewer.username
    end

    def reviewed_book_title(review)
        review.reviewed_book.title
    end

    def authorized_to_edit_review?(review)
        review.reviewer == current_user
    end
    
    def authorized_to_destroy_review?(review)
        admin? || review.reviewer == current_user
    end

    def user_reviewed_book_already?(book)
        !current_user.reviews.where(reviewed_book: book).empty?
    end
end
