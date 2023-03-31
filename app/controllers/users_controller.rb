class UsersController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]
  def index
    @cars = Car.all
  end

  def login
    render :login
  end

  def create
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user
      session[:user_id] = @user.id
      cookies[:user_name] = @user.username
      flash[:notice] = "You have Successfully Logged in!"
      redirect_to events_path
    else
      flash[:alert] = 'Invalid username & password.'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    cookies.delete :user_name
    flash[:notice] = "You have Successfully Logged out!"
    redirect_to login_path
  end
end
