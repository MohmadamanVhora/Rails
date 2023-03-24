class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  helper_method :current_user

  private

  def current_user
    @current_user = User.where(id: session[:user_id]).first
  end

  def record_not_found
    render file: 'public/404.html', status: 404
  end
end
