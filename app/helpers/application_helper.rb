module ApplicationHelper

    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    # Add admin_authorization? check for certain features such as users index, delete
    # Add authorized? for users new, create, update, and show actions
end
