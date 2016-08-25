class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper    #this will allow to use SessionHelper methods in all the controllers
  
  private
  
  # confirms a logged-in user
  def logged_in_user
    unless logged_in?   #this is equivalent to if !logged_in? or user is not logged in
      store_location    #session help method that stores the accessed url
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
