class EnrollmentsController < ApplicationController
  def index
    # events_ids = Enrollment.where(user_id: @current_user[:id]).pluck(:event_id).uniq
    events_ids = @current_user.enrollments.pluck(:event_id).uniq
    @events = Event.where.not(id: events_ids)
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

  def discard
    enrolled_event = Enrollment.find_by(user_id: @current_user[:id], event_id: params[:eventid], created: false)
    enrolled_event.destroy
    redirect_to profiles_path
  end
end
