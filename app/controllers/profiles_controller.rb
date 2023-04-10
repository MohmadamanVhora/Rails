class ProfilesController < ApplicationController
  def index
    events_ids = @current_user.enrollments.where(created: false).pluck(:event_id).uniq
    @events = Event.where(id: events_ids)
    # @events = Event.where(id: Enrollment.where(created: true).where.not(user_id: @current_user[:id]).pluck(:event_id))
    # @enrolled_events = Enrollment.where(user_id: @current_user[:id], created: false).pluck(:event_id)
    @address = Address.find_by(user_id: @current_user[:id])
  end
end
