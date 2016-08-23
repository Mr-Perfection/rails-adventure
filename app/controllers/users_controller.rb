class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index ,:edit, :update, :destroy]    #will prevent the unauthorized user from modifying the user's data without log in.
  before_action :correct_user,    only: [:edit, :update]    #will only allow correct user to modify his/her profile.
  before_action :admin_user,      only: :destroy
  def index
    @users = User.where(activated: true).paginate(page: params[:page])   #page param comes from "will_paginate" and it will display 30 users (by default) per page.
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to root_path unless @user.activated?
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activeate your account"
      redirect_to root_url #redirect to the home page
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
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)    #only allow certain attributes to update/add
  end
  
  # before filters
  # confirms a logged-in user
  def logged_in_user
    unless logged_in?   #this is equivalent to if !logged_in? or user is not logged in
      store_location    #session help method that stores the accessed url
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)   #redirect if logged in user is not current user
  end
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
