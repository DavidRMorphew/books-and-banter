module ApplicationHelper

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    # Add admin_authorization? check for certain features such as users index, delete
    def admin_authorization?
        !!current_user.admin
    end

    def redirect_if_not_logged_in
        if !logged_in?
            redirect_to login_path
        end
    end
    # Add authorized? for users new, create, update, and show actions
    def redirect_if_not_admin_authorized
        if !admin_authorization?
            flash[:message] = "You do not have authorization for that action. If you have an admin account, please log in as an admin."
            redirect_to login_path
        end
    end
end
