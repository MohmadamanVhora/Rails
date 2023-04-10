class ProfilesController < ApplicationController
  def index
    events_ids = @current_user.enrollments.where(created: false).pluck(:event_id).uniq
    @events = Event.where(id: events_ids)
    @address = Address.find_by(user_id: @current_user[:id])
  end
end
