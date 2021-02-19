module ReviewsHelper
    def display_boolean_yes_no(boolean)
        true ? "Yes" : "No"
    end

    def review_title
        tag.h1("'#{@book.title},' reviewed by #{current_user.username}")
    end
end
