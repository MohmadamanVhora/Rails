class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :destroy]

  def index
    events_ids = @current_user.enrollments.where(created: true).pluck(:event_id).uniq
    @events = Event.where(id: events_ids).order(id: :desc)
    # @events = @current_user.events.where(id: Enrollment.where(created: true, user_id: @current_user.id).pluck(:event_id))
  end

  def show
    @comments = @event.comments
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      @event.enrollments.create(user_id: @current_user.id, created: true)
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

  def search
    if params[:category_id].present?
      events_ids = @current_user.enrollments.where(created: true).pluck(:event_id)
      @events = Event.where(id: events_ids, category_id: params[:category_id]).order(id: :desc)
      render :index
    else
      events_ids = @current_user.enrollments.where(created: true).pluck(:event_id)
      @events = Event.where(id: events_ids).order(id: :desc)
      render :index
    end
  end
  
  private
  def event_params
    params.require(:event).permit(:name, :description, :event_date, :category_id)
  end

  def find_event
    @event = Event.find_by(id: Enrollment.where(user_id: @current_user[:id], event_id: params[:id]).pluck(:event_id))
  end

  def check_user
    if @event.enrollments.find_by(created: true).user != @current_user
      flash[:alert] = "You can not edit this event"
      redirect_to @event
    end
  end
end
