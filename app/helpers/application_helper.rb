module ApplicationHelper

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    # Add admin_authorization? check for certain features such as users index, delete
    def admin?
        !!current_user.admin
    end

    def redirect_if_not_logged_in
        if !logged_in?
            redirect_to login_path
        end
    end
    # Add authorized? for users new, create, update, and show actions
    def redirect_if_not_admin
        if !admin?
            flash[:message] = "You do not have authorization for that action. If you have an admin account, please log in as an admin."
            redirect_to login_path
        end
    end

    def authorized_to_view?(user)
        admin? || user == current_user
    end

    def redirect_if_not_authorized_to_view(user)
        if !authorized_to_view?(user)
            flash[:message] = "You are not authorized to view that page"
            redirect_to user_path(current_user)
        end
    end
end
