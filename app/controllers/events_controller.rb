class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.where(id: Enrollment.where(user_id: @current_user[:id], created: true).pluck(:event_id)).order(id: :desc)
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      Enrollment.create(event_id: @event.id, user_id: @current_user[:id], created: true)
      redirect_to @event
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy 
    redirect_to events_path, status: :see_other
  end

  private
  def event_params
    params.require(:event).permit(:name, :description, :event_date)
  end

  def find_event
    @event = Event.find_by(id: Enrollment.where(user_id: @current_user[:id], event_id: params[:id]).pluck(:event_id))
  end
end
