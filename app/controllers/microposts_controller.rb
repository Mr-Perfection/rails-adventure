class MicropostsController < ApplicationController
    
    #user has to be logged in before creating or deleting a post
    before_action :logged_in_user, only: [:create, :destroy]
    def create
    end

    def destroy
    end
    
end
