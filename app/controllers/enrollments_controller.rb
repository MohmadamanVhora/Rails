class EnrollmentsController < ApplicationController
  def index
    @events = Event.where(id: Enrollment.where(created: true).where.not(user_id: @current_user[:id]).pluck(:event_id))
    @enrolled_events = Enrollment.where(user_id: @current_user[:id], created: false).pluck(:event_id)
  end

  def create
    @enrollment = Enrollment.new(user_id: @current_user[:id], event_id: params[:eventid], created: false)
    if @enrollment.save
      flash[:notice] = "You have Enrolled Event Successfully"
      redirect_to enrollments_path
    else
      render :index, status: :unprocessable_entity
    end
  end
end
