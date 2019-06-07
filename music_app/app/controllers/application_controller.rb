class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in? 

    def log_in_user!(user)
        session[:session_token] = user.reset_session_token! 
    end

    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_logged_in 
        redirect_to new_session_url unless logged_in? 
    end

    def log_out! 
        current_user.reset_session_token! if current_user 
        session[:session_token] = nil 
        @current_user = nil 
    end
end
