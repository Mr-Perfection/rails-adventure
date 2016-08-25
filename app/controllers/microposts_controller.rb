class MicropostsController < ApplicationController
    
    #user has to be logged in before creating or deleting a post
    before_action :logged_in_user, only: [:create, :destroy]
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:succes] = "Micropost created!"
            redirect_to root_path
        else
            render 'static_pages/home'
        end
    end

    def destroy
    end
    
    private
    
    def micropost_params
        params.require(:micropost).permit(:content)
    end
    
end
