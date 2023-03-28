class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :current_user
  before_action :require_login

  private
  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def record_not_found
    render file: 'public/404.html', status: 404
  end

  def require_login
    return true if current_user.present?
    flash[:alert] = "You must be logged in to get access"
    redirect_to login_path
  end
end
