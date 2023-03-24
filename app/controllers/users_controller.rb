class UsersController < ApplicationController
  def index
    @cars = Car.all

    if current_user == nil
      render 'shared/login_page'
    end
  end

  def create
    @user = User.where(username: params[:username]).where(password: params[:password]).first
    if @user
      session[:user_id] = @user.id
      cookies[:user_name] = @user.username
      flash[:notice] = "You have Successfully Logged in!"
    else
      flash[:alert] = 'Invalid username & password.'
    end

    redirect_to users_path
  end

  def destroy
    session.clear
    cookies.delete :user_name
    redirect_to users_path
    flash[:notice] = "You have Successfully Logged out!"
  end
end
