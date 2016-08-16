class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]   #will prevent the unauthorized users from modifying the user's data
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #logged in as user upon sign up
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #redirect to the user profile
    else
      render 'new' #if failed, render sign up page
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  #confirms a logged-in user
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
