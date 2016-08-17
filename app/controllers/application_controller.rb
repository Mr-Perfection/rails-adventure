class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper    #this will allow to use SessionHelper methods in all the controllers
end
