module SessionsHelper
    
    def log_in(user)
        session[:user_id] = user.id
    end
    
    #remember user in a persistent session
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id    #store the user id into cookies
        cookies.permanent[:remember_token] = user.remember_token     #store the token into cookies
    end

    # Returns the user corresponding to the remember token cookie.
    def current_user
        if (user_id = session[:user_id])    #if session exists then asssign user id.
            @current_user ||= User.find_by(id: user_id)     #assign to current user with found user with user_id
        elsif (user_id = cookies.signed[:user_id])        #if session exists then asssign user id.
        
            user = User.find_by(id: user_id)        #assign user matched with user id
            if user && user.authenticated?(cookies[:remember_token])    #check if user exists and user authenticated with the cookies remember token
                log_in user     #log in as user
                @current_user = user        #store user into current user variable
            end
        end
    end
    
    
    
    # Returns true if the user is logged in, false otherwise.
    def logged_in?
        !current_user.nil?
    end
    
    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
    def log_out
        forget(current_user)
        session.delete(:user_id) #delte the session
        @current_user = nil #set the variable to nil value
    end
end
