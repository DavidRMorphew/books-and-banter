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

    def authorized_to_edit_review?(review)
        if review.reviewer != current_user 
            flash[:message] = "You are not authorized to edit that review"
            redirect_to user_path(current_user)
        end
    end

    def authorized_to_destroy?(review)
        unless admin? || review.reviewer == current_user
            flash[:message] = "You are not authorized to remove that review"
            redirect_to user_path(current_user)
        end
    end
end
